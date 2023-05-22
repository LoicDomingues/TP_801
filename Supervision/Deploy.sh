#TODO Verify when Sondage.py and Centralisation.py are finished
#!/bin/bash

# List of machines to deploy to
MACHINES=(C2 C3)

# Path to deploy scripts to
DEPLOY_PATH=/usr/local/bin

# Loop over machines and copy scripts
for machine in ${MACHINES[@]}; do
    echo "Deploying scripts to $machine"
    scp probe.py $machine:$DEPLOY_PATH/probe.py
done
