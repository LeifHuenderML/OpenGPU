#!/bin/bash

set -e

echo "Joining the Kubernetes cluster..."
# sudo kubeadm join [MASTER_IP]:6443 --token [TOKEN] --discovery-token-ca-cert-hash sha256:[HASH]

echo "Worker node joined the cluster successfully."

echo "Installing NVIDIA drivers..."
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo ubuntu-drivers autoinstall

echo "Installing NVIDIA Container Toolkit..."
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit

echo "Installing NVIDIA Kubernetes device plugin..."
kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/master/nvidia-device-plugin.yml

echo "Node GPU setup completed."
