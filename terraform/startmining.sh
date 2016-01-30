#!/bin/bash

# script that runs when servers come up. 
# spin up 2 docker containers per node for fun.
for i in $(seq 2); do 
  docker run -d -e 'ETH_NETWORK_ID=99991' \
              -e 'MINERTHREADS=1' \
              --name ethereum-0${i} \
              vallard/ethereum
done
