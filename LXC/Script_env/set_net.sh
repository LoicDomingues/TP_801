#!/bin/bash

# Vérifier si l'utilisateur a des droits sudo
if [ $(id -u) -ne 0 ] && ! sudo -n true 2>/dev/null; then
  echo "Vous devez avoir des droits sudo pour exécuter ce script."
  exit 1
fi

# Créer le pont réseau
ip link add Alphonse type bridge

# Ajouter une interface réseau au pont
#sudo ip link set dev ens master Alphonse

# Configurer l'adresse IP du pont
ip addr add 110.11.2.178/24 dev Alphonse

# Activer le pont réseau
ip link set dev Alphonse up

# Activer le routage
sudo sysctl -w net.ipv4.ip_forward=1

# Ajouter une règle NAT pour les paquets sortants
sudo iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE


#lxc-start -n ct2 -d