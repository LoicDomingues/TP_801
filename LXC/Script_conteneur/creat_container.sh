#!/bin/bash

# Récupération des paramètres d'entrée
template="$1"
network="$2"
memory="$3"
cpu="$4"
password="$5"
container_name="$6"

# Vérification que tous les paramètres ont été fournis
if [ $# -ne 6 ]
then
    echo "Usage: $0 <template> <network> <memory> <cpu> <password> <container_name>"
    exit 1
fi

# Vérifier si l'utilisateur a des droits sudo
if [ $(id -u) -ne 0 ] && ! sudo -n true 2>/dev/null; then
  echo "Vous devez avoir des droits sudo pour exécuter ce script."
  exit 1
fi

# Création du conteneur
lxc-create -t download -n $container_name -- -d $template -r focal -a amd64

# Modifier la configuration du conteneur pour définir les ressources
lxc config set $container_name limits.cpu $cpu
lxc config set $container_name limits.memory $memory

# Définir le mot de passe root du conteneur
echo "root:$password" | chroot /var/lib/lxc/$container_name/rootfs chpasswd

#Commande
#sudo ./creat_container.sh ubuntu Alphonse 1GB Arthur Arthur