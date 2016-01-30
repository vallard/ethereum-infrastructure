#!/bin/bash
date >/tmp/date-of-birth

# grab the source and build 
git clone https://github.com/vallard/ethereum-infrastructure.git
cd ethereum-infrastructure/Docker
docker build -t vallard/ethereum:latest . 
# hacks to try to make the image persist after imaging. 
sudo systemctl restart docker
docker images
