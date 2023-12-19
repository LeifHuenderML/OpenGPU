#!/bin/bash

set -e

echo "Updating system packages..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

echo "Disabling swap..."
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "Installing Docker..."
sudo apt-get install -y docker.io

echo "Installing Kubernetes components (kubeadm, kubelet, kubectl)..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Adding user to the 'docker' group..."
sudo usermod -aG docker $USER

echo "Node pre-requisites installation completed."
