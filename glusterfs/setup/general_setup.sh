sudo apt-get update
sudo apt-get install -y glusterfs-server
sudo systemctl start glusterfs-server
sudo systemctl enable glusterfs-server

#updated to be dynamic in building a gluster
sudo gluster peer probe glusterfs-node-1
sudo gluster peer status


sudo mkdir -p /training_data
sudo gluster volume create gv0 replica 2 glusterfs-node-1:/gluster-data glusterfs-node-2:/gluster-data
sudo gluster volume start gv0

sudo apt-get install -y glusterfs-client

