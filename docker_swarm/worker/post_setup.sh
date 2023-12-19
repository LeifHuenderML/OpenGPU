#!/bin/bash

# Function to check NVIDIA drivers
check_nvidia_drivers() {
    # Check if nvidia-smi command is available
    if ! command -v nvidia-smi &> /dev/null; then
        echo "nvidia-smi command not found. NVIDIA drivers may not be installed correctly."
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

# Call the function to check NVIDIA drivers
check_nvidia_drivers
