#!/usr/bin/env python3

import os
import tarfile
import zipfile
import argparse


def extract_zip(archive_file, install_dir):
    with zipfile.ZipFile(archive_file, "r") as archive:
        archive.extractall(install_dir)


def extract_tar(archive_file, install_dir):
    with tarfile.open(archive_file, "r") as archive:
        archive.extractall(install_dir)


def extract_tgz(archive_file, install_dir):
    with tarfile.open(archive_file, "r:gz") as archive:
        archive.extractall(install_dir)


def extract_archive(archive_file, install_dir):
    # Check if archive file exists
    if not os.path.isfile(archive_file):
        print(f"Error: Archive file '{archive_file}' does not exist.")
        return

    # Check if installation directory exists and is writable
    if not os.path.isdir(install_dir):
        print(f"Error: Installation directory '{install_dir}' does not exist.")
        return
    if not os.access(install_dir, os.W_OK):
        print(f"Error: Installation directory '{install_dir}' is not writable.")
        return

    # Determine archive type based on file extension
    ext = os.path.splitext(archive_file)[1]
    if ext == ".zip":
        extract_zip(archive_file, install_dir)
    elif ext == ".tar":
        extract_tar(archive_file, install_dir)
    elif ext == ".tgz" or ext == ".tar.gz":
        extract_tgz(archive_file, install_dir)
    else:
        print(f"Error: Archive type '{ext}' is not supported.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract archive to installation directory.")
    parser.add_argument("archive_file", help="name of the archive file to extract")
    parser.add_argument("install_dir", help="name of the installation directory")
    args = parser.parse_args()

    extract_archive(args.archive_file, args.install_dir)
