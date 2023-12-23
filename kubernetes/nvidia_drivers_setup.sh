#install nvidia drivers
sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt-get update
sudo ubuntu-drivers autoinstall
(sudo crontab -l 2>/dev/null; echo "@reboot general_setup_2.sh") | sudo crontab -
sudo reboot

