#!/usr/bin/env python3
import os
from datetime import datetime

# Définition du nom du fichier de sortie
filename = "userinfo_" + datetime.now().strftime("%Y%m%d_%H%M%S") + ".txt"

# Obtention de l'information de l'utilisateur
username = os.getlogin()
userid = os.getuid()
groups = os.getgroups()

# Affichage des informations à l'utilisateur
print("Nom d'utilisateur :", username)
print("ID d'utilisateur :", userid)
print("Groupes d'utilisateur :", groups)

# Enregistrement des informations dans un fichier
with open(filename, "w") as f:
    f.write("Nom d'utilisateur : " + username + "\n")
    f.write("ID d'utilisateur : " + str(userid) + "\n")
    f.write("Groupes d'utilisateur : " + str(groups) + "\n")

print("Les informations ont été enregistrées dans le fichier", filename)