#!/bin/bash

# Vérifier si l'utilisateur a des droits sudo
if [ $(id -u) -ne 0 ] && ! sudo -n true 2>/dev/null; then
  echo "Vous devez avoir des droits sudo pour exécuter ce script."
  exit 1
fi

# Mettre à jour la liste des packages
sudo apt update

# Installer les packages nécessaires pour LXC
sudo apt install lxc bridge-utils -y
