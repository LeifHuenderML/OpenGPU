#!/bin/bash

# Function to check the exit status of the last command executed
check_status() {
    if [ $? -ne 0 ]; then
        echo "An error occurred: $1"
        exit 1
    fi
}

echo "Updating package lists..."
sudo apt-get update
check_status "Failed to update package lists."

echo "Installing prerequisites..."
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
check_status "Failed to install prerequisites."

echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
check_status "Failed to add Docker's GPG key."

echo "Setting up Docker repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
check_status "Failed to set up Docker repository."

echo "Updating package lists after adding Docker repository..."
sudo apt-get update
check_status "Failed to update package lists after adding Docker repository."

echo "Installing Docker..."
sudo apt-get install docker-ce -y
check_status "Failed to install Docker."

echo "Docker installation completed successfully."

echo "Are you setting up a manager node or a worker node? (type m for manager or w for worker)"
read node_type

if [ "$node_type" = "m" ]; then
    echo "Setting up a manager node..."
    # Call or execute the script or commands for setting up a manager node
    /master/setup.sh
elif [ "$node_type" = "w" ]; then
    echo "Setting up a worker node..."
    # Call or execute the script or commands for setting up a worker node
    /worker/setup.sh
else
    echo "Invalid input. Please enter 'm' or 'w'."
    exit 1
fi

