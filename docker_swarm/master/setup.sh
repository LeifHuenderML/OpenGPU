#!/bin/bash

# Function to get the primary IP address
get_primary_ip() {
    # This command gets the primary IP address assigned to the first non-loopback network interface
    ip addr show scope global | awk '/inet /{print $2}' | cut -d/ -f1 | head -n 1
}

# Function to check the exit status of the last command executed
check_status() {
    if [ $? -ne 0 ]; then
        echo "An error occurred: $1"
        exit 1
    fi
}

# Initialize Docker Swarm
init_swarm() {
    local ip_addr=$(get_primary_ip)
    if [[ -z "$ip_addr" ]]; then
        echo "Unable to determine the primary IP address."
        exit 1
    fi

    echo "Initializing Docker Swarm with IP: $ip_addr"
    sudo docker swarm init --advertise-addr "$ip_addr"
    check_status "Failed to initialize Docker Swarm."

    sudo docker network create --driver overlay --attachable openGPU_swarm_network
    check_status "Failed to initiaize network overlay"
}

# Main function
main() {
    init_swarm
}

# Execute the main function
main
