#!/bin/bash

set -e

echo "Initializing the Kubernetes cluster..."
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

echo "Setting up local kubeconfig..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Applying network plugin (Calico)..."
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo "Master node setup completed."
