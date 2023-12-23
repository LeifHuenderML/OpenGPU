#!/bin/bash

# Update and upgrade packages
sudo apt-get update && sudo apt-get upgrade -y

# Makes all scripts executable for openGPU repository
find . -type f -exec chmod +x {} \;

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

