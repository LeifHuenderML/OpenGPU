#!/bin/bash

sudo apt-get update && sudo apt-get install -y wireguard
#generate private and public keys
wg genkey | tee privatekey | wg pubkey > publickey
#config wireguard 
private_key=&(cat privatekey)
echo "[Interface] 
PrivateKey = &private_key 
Address = 172.16.0.0/16
ListenPort = 39349

[Peer]
PublicKey = 
AllowedIPs = 
Endpoint = :39349" | sudo tee /etc/wireguard/wg0.conf

sudo wg-quick up wg0
sudo systemctl enable wg-g