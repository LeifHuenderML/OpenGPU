#!/bin/bash

set -e

echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing necessary packages..."
sudo apt-get install -y jq build-essential

echo "Retrieving Docker Swarm join command..."
response=$(curl -s http://192.168.1.192:5000/join_swarm || { echo "Failed to connect to the server."; exit 1; })
join_command=$(echo $response | jq -r .command)

if [ -n "$join_command" ]; then
    echo "Joining Docker Swarm..."
    eval $join_command
else
    echo "Failed to retrieve the Docker Swarm join command."
    exit 1
fi

echo "Setting up NVIDIA drivers..."
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

echo "System needs to be rebooted to complete the installation."
read -p "Do you want to reboot now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo reboot
else
    echo "Please reboot the system manually to apply changes."
fi
