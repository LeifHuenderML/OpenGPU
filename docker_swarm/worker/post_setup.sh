#!/bin/bash

# Function to check for the presence of an NVIDIA GPU
check_for_nvidia_gpu() {
    # Check if any NVIDIA GPU is listed in the PCI devices
    if lspci | grep -qi nvidia; then
        echo "NVIDIA GPU detected in the system."
        return 0
    else
        echo "No NVIDIA GPU detected in the system. NVIDIA driver check is not applicable."
        return 1
    fi
}

# Function to check NVIDIA drivers
check_nvidia_drivers() {
    # Check if nvidia-smi command is available
    if ! command -v nvidia-smi &> /dev/null; then
        echo "nvidia-smi command not found. This could be due to missing NVIDIA drivers or no NVIDIA GPU in the system."
        return 1
    fi

    # Execute nvidia-smi and capture its output
    nvidia_output=$(nvidia-smi)

    # Check for 'Driver Version' in the nvidia-smi output
    if grep -q "Driver Version" <<< "$nvidia_output"; then
        echo "NVIDIA drivers are installed. Here is some information about your GPU:"
        echo "$nvidia_output"
        return 0
    else
        echo "NVIDIA drivers are not properly installed."
        return 1
    fi
}

# First, check if an NVIDIA GPU is present
if check_for_nvidia_gpu; then
    # If an NVIDIA GPU is present, check the drivers
    check_nvidia_drivers
fi
