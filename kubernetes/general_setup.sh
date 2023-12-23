#credit goes to https://hbayraktar.medium.com/how-to-install-kubernetes-cluster-on-ubuntu-22-04-step-by-step-guide-7dbf7e8f5f99
#for giving most of the setup implementation found here

sudo apt update
sudo apt upgrade -y
if lspci | grep -i nvidia; then
    ./nvidia_driver_setup.sh
else
    ./general_setup_2.sh
fi
