#!/bin/bash

geth --genesis /home/ubuntu/ethereum/private-genesis.json \
     --datadir /home/ubuntu/ethereum/ethdata/  \
     --networkid ${ETH_NETWORK_ID} \
     --rpc --rpcapi "personal,eth,web3" \
     --mine --minerthreads ${MINERTHREADS} | tee -a ~/ethereum.log
