# Docker image

Build the docker image.  You can then run with: 

```
docker run -p 8545:8545 -p 30303:30303 -d --name ethereum -e 'ETH_NETWORK_ID=991' -e 'MINERTHREADS=1' vallard/ethereum
```

Next you can attach to the container: 

```
docker run -P -it --rm vallard/ethereum /bin/bash
```

Next you attach to the Running ethereum client

```
geth --datadir /home/ubuntu/ethereum/ethdata attach
```
Next show the accounts in the system and the balance.
``` 
eth.accounts;
tom = eth.accounts[0];
web3.fromWei(eth.getBalance(tom), 'ether');
```
## Create New Account
```
personal.newAccount()
eth.accounts;
val = eth.accounts[1];
web3.fromWei(eth.getBalance(val), 'ether');
```
### Create account using JSON
```
admin.stopRPC();
admin.startRPC("127.0.0.1",8545,"*","web3,db,net,eth,personal");
```
Now exit the geth terminal.
Now, back inside the container show the JSON RPC to create a new account. 
```
curl -X POST \
--data '{"jsonrpc":"2.0","method":"personal_newAccount", "params":["pass"], "id":74}' \
localhost:8545
```
## Transfer money from one account to the other account
```
personal.unlockAccount(tom);
eth.sendTransaction({from: tom, to: val, value: web3.toWei(100, "ether")})}
web3.fromWei(eth.getBalance(val), 'ether');
```
You'll see that val still doesn't have any money!  So sad.  So we have to mine. 
```
miner.start();
```
The output will look like: 
```
> I0215 13:15:38.036411      37 miner.go:119] Starting mining operation (CPU=1 TOT=4)
I0215 13:15:38.044264      37 worker.go:571] commit new work on block 3 with 1 txs & 0 uncles. Took 5.631081ms
```

Now you can see if Val has money? 
web3.fromWei(eth.getBalance(val), 'ether');
