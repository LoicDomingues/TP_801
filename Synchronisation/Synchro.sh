#TODO Verify when lxc scripts are finished
#!/bin/bash

# Get sync list
rsync c1:/var/sync_list.txt .

# Sync directories and files
while read line; do
    rsync -avz --delete c1:"$line" c2:"$line"
    rsync -avz --delete c1:"$line" c3:"$line"
done < sync_list.txt

# Get sync status on C2 and C3
echo "Sync status on C2:"
rsync c2:/var/sync_status.txt -
echo "Sync status on C3:"
rsync c3:/var/sync_status.txt -

# Save sync operations on C1
rsync /var/sync_operations.txt c1:/var/sync_operations.txt