#!/bin/bash

sudo apt-get update -y
sudo echo "$IP_PREFIX$((IP_LAST_TERM_START)) controlplane" >> /etc/hosts
for i in `seq 1 ${NUM_WORKER_NODES}`; do
  sudo echo "$IP_PREFIX$((IP_LAST_TERM_START+i)) node0${i}" >> /etc/hosts
done
