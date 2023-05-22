#TODO Verify when lxc scripts are finished
#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 [path/to/directory/or/file]"
    exit 1
fi

echo "$1" >> /var/sync_list.txt
echo "Added $1 to sync list"
