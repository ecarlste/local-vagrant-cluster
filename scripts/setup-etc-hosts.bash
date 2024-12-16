#!/bin/bash

sudo apt-get update -y
sudo echo "$IP_PREFIX$((IP_LAST_TERM_START)) controlplane" >> /etc/hosts
for i in `seq 1 ${WORKER_NODE_COUNT}`; do
  sudo echo "$IP_PREFIX$((IP_LAST_TERM_START+i)) node0${i}" >> /etc/hosts
done
