#!/bin/bash

set -e

echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing necessary packages..."
sudo apt-get install -y jq build-essential

echo "Retrieving Docker Swarm join command..."
response=$(curl -s http://192.168.1.192:5000/join_swarm || { echo "Failed to connect to the api server."; exit 1; })
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

echo "Installing NVIDIA Container Toolkit..."
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit

echo "Restarting Docker to apply changes..."
sudo systemctl restart docker

echo "System needs to be rebooted to complete the installation."
read -p "Do you want to reboot now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo reboot
else
    echo "Please reboot the system manually to apply changes."
fi
