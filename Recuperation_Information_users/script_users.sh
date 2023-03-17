#!/bin/bash

# Définition du nom du fichier de sortie
filename="userinfo_$(date +%Y%m%d_%H%M%S).txt"

# Obtention de l'information de l'utilisateur
username=$(whoami)
userid=$(id -u)
groups=$(id -Gn)

# Affichage des informations à l'utilisateur
echo "Nom d'utilisateur : $username"
echo "ID d'utilisateur : $userid"
echo "Groupes d'utilisateur : $groups"

# Enregistrement des informations dans un fichier
echo "Nom d'utilisateur : $username" >> $filename
echo "ID d'utilisateur : $userid" >> $filename
echo "Groupes d'utilisateur : $groups" >> $filename

echo "Les informations ont été enregistrées dans le fichier $filename"
