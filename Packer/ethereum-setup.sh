#!/bin/bash
date >/tmp/date-of-birth

# grab the source and build 
git clone https://github.com/vallard/ethereum-infrastructure.git
cd ethereum-infrastructure/Docker
sudo docker build -t vallard/ethereum:latest . 
# hacks to try to make the image persist after imaging. 
echo "Restarting docker"
sudo systemctl restart docker
sleep 20
docker images
