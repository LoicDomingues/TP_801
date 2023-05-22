#!/bin/bash

# Create a file with random content
filename="my_file.txt"
dd if=/dev/urandom of=$filename bs=1 count=1024

# Create a tar archive
tar -cvf $filename.tar $filename

# Create a zip archive
zip $filename.zip $filename

# Create a tgz archive
tar -czvf $filename.tgz $filename

# Remove original file
rm $filename
