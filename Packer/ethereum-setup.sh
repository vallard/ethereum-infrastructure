#!/bin/bash
date >/tmp/date-of-birth

# grab the source and build 
git clone https://github.com/vallard/ethereum-infrastructure.git
cd ethereum-infrastructure/Docker
sudo docker build -t vallard/ethereum:latest . 
# hacks to make sure the docker image is preserved!
echo "Restarting docker"
sudo systemctl restart docker
sleep 40
docker images
