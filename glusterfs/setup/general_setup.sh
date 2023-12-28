#!/bin/bash

# Variables
NODE_NAME=$(hostname)
CONFIG_FILE="glusterfs_nodes.conf"

# Check if the configuration file already exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating a new configuration file: $CONFIG_FILE"
    echo "$NODE_NAME" > "$CONFIG_FILE"
else
    echo "Configuration file $CONFIG_FILE already exists. Please add existing node IP addresses manually."
fi

# Read IP addresses from the configuration file
EXISTING_NODES=($(cat "$CONFIG_FILE"))

# Check if the configuration file is empty or contains invalid data
if [ ${#EXISTING_NODES[@]} -eq 0 ]; then
    echo "Error: The configuration file is empty or contains invalid data."
    exit 1
fi

# Update and install GlusterFS server
sudo apt-get update
sudo apt-get install -y glusterfs-server
sudo systemctl start glusterfs-server
sudo systemctl enable glusterfs-server

# Probe peers (skip probing itself)
for EXISTING_NODE in "${EXISTING_NODES[@]}"; do
    if [ "$EXISTING_NODE" != "$NODE_NAME" ]; then
        sudo gluster peer probe "$EXISTING_NODE"
    fi
done

# Check peer status
sudo gluster peer status

# Create GlusterFS volume
sudo mkdir -p /training_data
EXISTING_NODES_STRING=$(IFS=,; echo "${EXISTING_NODES[*]}")
sudo gluster volume create gv0 replica 2 "$NODE_NAME:/gluster-data" "$EXISTING_NODES_STRING:/gluster-data"
sudo gluster volume start gv0

# Install GlusterFS client
sudo apt-get install -y glusterfs-client
