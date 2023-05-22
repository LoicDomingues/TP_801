#!/bin/bash

# Check if the required parameters are provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 archive installation_dir"
    exit 1
fi

# Get the archive filename and extension
archive="$1"
extension="${archive##*.}"

# Check if the archive file exists and is readable
if [[ ! -f "$archive" || ! -r "$archive" ]]; then
    echo "Error: Archive file $archive does not exist or is not readable"
    exit 1
fi

# Check if the installation directory exists and is writable
if [[ ! -d "$2" || ! -w "$2" ]]; then
    echo "Error: Installation directory $2 does not exist or is not writable"
    exit 1
fi

# Determine the archiver based on the archive extension
case "$extension" in
    zip)
        archiver="unzip $archive -d $2"
        ;;
    tar)
        archiver="tar -xf $archive -C $2"
        ;;
    tgz)
        archiver="tar -xzf $archive -C $2"
        ;;
    *)
        echo "Error: Unsupported archive type $extension"
        exit 1
        ;;
esac

# Extract the archive to the installation directory
$archiver

# Print a success message
echo "Archive $archive extracted to $2"
