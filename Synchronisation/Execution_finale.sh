#TODO Verify when Synchro.sh, Sauvegarde_synchro.sh and Ajout_synchro.sh are finished
#!/bin/bash

# Add directories and files to sync list
ssh c1 "/var/scripts/Ajout_synchro.sh /var/data/dir1"
ssh c1 "/var/scripts/Ajout_synchro.sh /var/data/file1.txt"

# Sync directories and files
ssh c1 "/var/scripts/Synchro.sh"

# Save sync operations on C1
ssh c1 "/var/scripts/Sauvegarde_synchro.sh"

# Print sync operations
echo "Sync operations:"
ssh c1 "cat /var/sync_operations.txt"
