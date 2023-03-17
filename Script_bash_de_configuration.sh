#!/bin/bash

# Vérifier les arguments passés en paramètres
if [ $# -ne 5 ]; then
  echo "Usage: $0 <hostname> <interface> <address> <gateway> <dns>"
  exit 1
fi

# Définir les variables
HOSTNAME="$1"
INTERFACE="$2"
ADDRESS="$3"
GATEWAY="$4"
DNS="$5"


# Affectation du nom de l'hôte
hostnamectl set-hostname "$HOSTNAME"

# Vérification de l'existence de l'interface réseau
if ! ip link show "$INTERFACE" > /dev/null 2>&1; then
  echo "Error: Interface $INTERFACE not found"
  exit 1
fi

# Désactivation de la carte réseau
#ip link set "$INTERFACE" down

#Modification du fichier netplan 
rm /etc/netplan/0-installer-config.yaml
echo "network:
    ethernets:
        ens3:
            dhcp4: no
            addresses: ["$ADDRESS"]
            gateway4: "$GATEWAY"
            nameservers: 
                addresses: ["$DNS"]
    version: 2" > /etc/netplan/0-installer-config.yaml

#On applique les modification du fichier netplan 
netplan apply

# Modification de l'adresse de la carte réseau
#ip addr add "$ADDRESS" dev "$INTERFACE"

# Ajout de la gateway
#ip route add default via "$GATEWAY" dev "$INTERFACE"

# Activation de l'interface réseau, et si nécessaire du service réseau
#ip link set "$INTERFACE" up
#systemctl restart network.service

# Modification de l'adresse du DNS
#echo "nameserver $DNS" > /etc/resolv.conf

# Test de connexion au réseau
if ! ping -c 3 google.com > /dev/null 2>&1; then
  echo "Error: Unable to connect to the network"
  exit 1
fi

echo "Configuration successfully applied"
exit 0
