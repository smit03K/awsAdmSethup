#!/bin/bash

sudo systemctl status containerd

sudo apt update

sudo sysctl -w net.ipv4.ip_forward=1

sudo chmod 777 /etc/sysctl.conf

sudo sed -i 's/^#\(net\.ipv4\.ip_forward[[:space:]]*=[[:space:]]*1\)/\1/' /etc/sysctl.conf

sudo sysctl -p

sudo apt install -y containerd

sudo systemctl enable --now containerd

sudo mkdir -p /etc/containerd

sudo chmod 777 /etc/containerd

sudo containerd config default > /etc/containerd/config.toml

sudo systemctl restart containerd

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl gpg

sudo mkdir -p -m 755 /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet

sudo snap install kube-apiserver
