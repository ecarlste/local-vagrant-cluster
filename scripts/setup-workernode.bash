#!/bin/bash

set -euxo pipefail

shared_kube_config_path="/vagrant/configs"

/bin/bash $shared_kube_config_path/workernode_join.sh -v

# Set up kubectl config for the vagrant user
vagrant_home="/home/vagrant"
sudo mkdir -p "$vagrant_home/.kube"
sudo cp -i /vagrant/configs/config "$vagrant_home/.kube/config"
sudo chown -R vagrant:vagrant "$vagrant_home/.kube"
