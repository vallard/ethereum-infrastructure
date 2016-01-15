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
from another terminal launch another client
```
docker run -it --rm -P --name ethereum02 vallard/ethereum /bin/bash
```      


Now you'll be in the docker container.  It's time to set the coinbase, make some accounts so we can mine. 

```
mkdir -p ~/eth
cd /home/ubuntu/ethereum
geth --genesis ./private-genesis.json --datadir ~/veth/  --networkid 696969 console
```

This will launch you onto the geth javascript console.  Let's set some stuff up so we can generate some 
money!
(Follow these instructions)[https://github.com/ethereum/go-ethereum/wiki/Contracts-and-Transactions#testing-contracts-and-transactions]
```
> personal.newAccount();
# Enter new password here twice!
> primary = eth.accounts[0];
> balance = web3.fromWei(eth.getBalance(primary), "ether");
0 # most likely, you won't have anything yet!
> miner.start(8);  # this will say true and start creating the stuff. 
```
The miner will generate a DAG.  In my setup it took 10 minutes: 
```
I0113 00:11:42.242515      24 ethash.go:237] Done generating DAG for epoch 0, it took 10m26.473408466s
``` 
Press ```Enter``` after this to get back to the javascript prompt. Now we can get the amount of ether 
that has been mined. 
```
> web3.fromWei(eth.getBalance(primary), "ether");
```




