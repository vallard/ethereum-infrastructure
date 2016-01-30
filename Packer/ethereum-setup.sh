#!/bin/bash
date >/tmp/date-of-birth

# grab the source and build 
git clone https://github.com/vallard/ethereum-infrastructure.git
cd ethereum-infrastructure/Docker
sudo docker build -t vallard/ethereum:latest . 
sudo docker pull hello-world
# hacks to make sure the docker image is preserved!
echo "Restarting docker"
sudo systemctl restart docker
sleep 40

# make it so cluster doesn't reboot
sudo systemctl stop update-engine.service
sudo systemctl disable update-engine.service
sudo systemctl stop locksmithd.service
sudo systemctl disable locksmithd.service
docker images
