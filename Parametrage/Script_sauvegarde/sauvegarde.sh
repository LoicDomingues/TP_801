#!/bin/bash

# Vérification des paramètres
if [ $# -ne 5 ]; then
  echo "Usage: $0 <archive_name> <directory_to_backup> <backup_server_address> <backup_server_login> <backup_server_password>"
  exit 1
fi

# Récupération des paramètres
archive_name=$1
directory_to_backup=$2
backup_server_address=$3
backup_server_login=$4
backup_server_password=$5

# Archivage du répertoire
tar -czf $archive_name $directory_to_backup

# Copie de l'archive via sftp
sftp $backup_server_login@$backup_server_address <<EOF
cd backups
put $archive_name
bye
EOF

# Vérification de la copie
if [ $? -eq 0 ]; then
  echo "L'archive $archive_name a été sauvegardée sur le serveur $backup_server_address avec succès."
else
  echo "Une erreur est survenue lors de la sauvegarde de l'archive $archive_name sur le serveur $backup_server_address."
fi

# Suppression de l'archive locale
rm "$archive_name"