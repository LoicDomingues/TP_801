#!/usr/bin/env python3
import os
import paramiko
import argparse
import tarfile

# Fonction pour créer une archive tar gz
def create_archive(archive_name, directory_name):
    with tarfile.open(archive_name, "w:gz") as tar:
        tar.add(directory_name, arcname=os.path.basename(directory_name))

# Fonction pour copier l'archive via sftp
def copy_to_sftp(archive_name, backup_server_address, login, password):
    transport = paramiko.Transport((backup_server_address, 22))
    transport.connect(username=login, password=password)
    sftp = paramiko.SFTPClient.from_transport(transport)
    sftp.put(archive_name, os.path.basename(archive_name))
    sftp.close()
    transport.close()

# Parser des arguments d'entrée
parser = argparse.ArgumentParser(description='Backup script')
parser.add_argument('archive_name', type=str, help='The name of the archive')
parser.add_argument('directory_name', type=str, help='The name of the directory to backup')
parser.add_argument('backup_server_address', type=str, help='The address of the backup server')
parser.add_argument('login', type=str, help='The login of the backup server')
parser.add_argument('password', type=str, help='The password of the backup server')
args = parser.parse_args()

# Création de l'archive
create_archive(args.archive_name, args.directory_name)

# Copie de l'archive via sftp
copy_to_sftp(args.archive_name, args.backup_server_address, args.login, args.password)

# Suppression de l'archive locale
os.remove(args.archive_name)

print("Archive successfully backed up to", args.backup_server_address)
