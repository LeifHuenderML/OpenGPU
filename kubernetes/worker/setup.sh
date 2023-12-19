#!/bin/bash

set -e

echo "Joining the Kubernetes cluster..."
# sudo kubeadm join [MASTER_IP]:6443 --token [TOKEN] --discovery-token-ca-cert-hash sha256:[HASH]

echo "Worker node joined the cluster successfully."
