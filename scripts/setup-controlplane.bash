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
  rm -rf $shared_kube_config_path
else
  mkdir -p $shared_kube_config_path
fi

cp -i /etc/kubernetes/admin.conf $shared_kube_config_path/config
touch $shared_kube_config_path/workernode_join.sh
chmod +x $shared_kube_config_path/workernode_join.sh

kubeadm token create --print-join-command > $shared_kube_config_path/workernode_join.sh

# Install Flannel CNI
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

# Set up kubectl config for the vagrant user
vagrant_home="/home/vagrant"
sudo mkdir -p "$vagrant_home/.kube"
sudo cp -i /etc/kubernetes/admin.conf "$vagrant_home/.kube/config"
sudo chown -R vagrant:vagrant "$vagrant_home/.kube"
