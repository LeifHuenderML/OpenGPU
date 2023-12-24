sudo kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

kubectl get pods -n kube-system
kubectl get nodes

#setup GlusterFS to manage the distributed file system accross the cluster
kubectl apply -f glusterfs/endpoints.yaml
kubectl apply -f glusterfs/service.yaml
kubectl apply -f glusterfs/pv.yaml
kubectl apply -f glusterfs/pvc.yaml
kubectl apply -f glusterfs/pod.yaml
