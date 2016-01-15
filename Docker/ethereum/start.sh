#!/bin/bash
geth --genesis /home/ubuntu/ethereum/private-genesis.json --datadir ~/veth/ --networkid 456321 --maxpeers 0 console | tee -a ~/ethereum.log
