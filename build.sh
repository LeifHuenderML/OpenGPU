#!/bin/bash

# Update and upgrade packages
sudo apt-get update && sudo apt-get upgrade -y

# Makes all scripts executable for openGPU repository
find . -type f -exec chmod +x {} \;

# Determine resources of system
# Get the available memory in megabytes
available_ram=$(free -m | awk '/^Mem:/ {print $7}')

# Define the threshold (4GB in MB)
threshold=4096

# Check if the available memory is greater than or equal to the threshold
if [ "$available_ram" -ge "$threshold" ]; then
    echo "Enough RAM available, adding this system to the training cluster."
    # Run general setup script
    ./kubernetes/general_setup.sh
    # Prompt for node type
    echo "Is this computer intended to be a master or worker node? (enter 'm' for master or 'w' for worker)"
    read input

    # Check input and run the appropriate script
    if [ "$input" == "m" ]; then
        ./kubernetes/master/setup.sh
    elif [ "$input" == "w" ]; then
        ./kubernetes/worker/setup.sh
    else
        echo "That was incorrect input. Try inputting a 'm' for master or 'w' for worker next time."
        exit 1
    fi
else
    echo "Not enough RAM, for the training cluster adding this machine to the distributed files system cluster."
    ./glusterfs/setup/general_setup.sh 
fi

