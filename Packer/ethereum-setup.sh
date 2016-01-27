#!/bin/bash
date >/tmp/date-of-birth

# grab the source and build 
git clone git@github.com:vallard/ethereum-infrastructure.git
cd Docker
docker build -t vallard/ethereum . 

