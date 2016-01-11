# ethereum-infrastructure
Infrastructure for setting up private Ethereum cluster on OpenStack using Ansible and Geth. 

Purpose is to run Ethereum in containers on a private network. 

## Documentation

Great document on starting a private chain:
http://adeduke.com/2015/08/how-to-create-a-private-ethereum-chain/

Instructions to get up and running and mine to do contracts: 
https://github.com/ethereum/go-ethereum/wiki/Contracts-and-Transactions#testing-contracts-and-transactions

Run the docker image: 
```
cd Docker
docker build -t vallard/ethereum . 
docker run -it --rm -P --name ethereum01 vallard/ethereum /bin/bash
```

Now you'll be in the docker container.  It's time to set the coinbase, make some accounts so we can mine. 

```
mkdir -p ~/dapp/testint/00/
geth --datadir ~/dapps/testing/00/ --port 30310 --rpcport 8110 --networkid 4567890 --nodiscover --maxpeers 0 --vmdebug --verbosity 6 --pprof --pprofport 6110 console 2>> ~/dapp/testint/00/00.log

