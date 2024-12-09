#!/bin/bash

set -euxo pipefail

sudo kubeadm init \
  --apiserver-advertise-address=$CONTROLPLANE_IP \
  --pod-network-cidr=$POD_CIDR \
  --upload-certs

# Set up kubectl config for the vagrant user
vagrant_home="/home/vagrant"
sudo mkdir -p "$vagrant_home/.kube"
sudo cp -i /etc/kubernetes/admin.conf "$vagrant_home/.kube/config"
sudo chown -R vagrant:vagrant "$vagrant_home/.kube"
