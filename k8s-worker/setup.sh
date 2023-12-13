#makes the node distinguishable as a worker node
sudo hostnamectl set-hostname kubeworker
#update and install kubernetes helper packages
sudo apt-get update && sudo apt-get install -y apt-transport-httpsgnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo “deb https://apt.kubernetes.io/ kubernetes-xenial main” | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
#installs kubernetes and packages on worker node
sudo apt-get install -y kubectl kubeadm kubelet kubelet kuberneses-cni docker.io
#get docker running
sudo systemctl start docker
sudo systemctl enable docker
#get k8s running
sudo systemctl start kubelet
sudo systemctl enable kubelet
#add current user to the docker group so docker commands can be run with root priveleges
sudo usermod -aG docker $user
newgrp docker
#enable iptables to see bridghed traffic 
cat << EOF | sudo tee /etc/sysctl.d/k8s/conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo systemctl - system
