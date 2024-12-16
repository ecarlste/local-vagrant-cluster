#!/bin/bash

set -euxo pipefail

sudo kubeadm init \
  --apiserver-advertise-address=$CONTROLPLANE_IP \
  --pod-network-cidr=$POD_CIDR \
  --upload-certs

# Set up kubectl config for the root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Save Configs to shared /vagrant location
shared_kube_config_path="/vagrant/configs"

if [ -d $shared_kube_config_path ]; then
  rm -f $shared_kube_config_path/*
else
  mkdir -p $shared_kube_config_path
fi

cp -i /etc/kubernetes/admin.conf $shared_kube_config_path/config
touch $shared_kube_config_path/workernode_join.sh
chmod +x $shared_kube_config_path/workernode_join.sh

kubeadm token create --print-join-command > $shared_kube_config_path/workernode_join.sh

# Install Flannel CNI w/ custom iface for Vagrant
curl -o /vagrant/configs/kube-flannel.yml \
  https://raw.githubusercontent.com/flannel-io/flannel/refs/tags/v0.26.2/Documentation/kube-flannel.yml
perl \
  -i.bak \
  -0777 \
  -pe 's/(\s*-\s*\/opt\/bin\/flanneld\s*\n\s*args:\s*)/$1- --iface=enp0s8\n        /' \
  /vagrant/configs/kube-flannel.yml 
kubectl apply -f /vagrant/configs/kube-flannel.yml

# Set up kubectl config for the vagrant user
vagrant_home="/home/vagrant"
sudo mkdir -p "$vagrant_home/.kube"
sudo cp -i /etc/kubernetes/admin.conf "$vagrant_home/.kube/config"
sudo chown -R vagrant:vagrant "$vagrant_home/.kube"
