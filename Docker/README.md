# Docker image

Build the docker image.  You can then run with: 

```
docker run -p 8545:8545 -p 30303:30303 -d --name ethereum -e 'ETH_NETWORK_ID=991' -e 'MINERTHREADS=1' vallard/ethereum
```

Next you can attach to the container: 

```
docker exec -it ethereum /bin/bash
```

Next you attach to the Running ethereum client

```
geth --datadir /home/ubuntu/ethereum/ethdata attach
```
Next show the accounts in the system and the balance.
``` 
prim = eth.accounts[0];
web3.fromWei(eth.getBalance(prim), 'ether');
```
Get the RPC to create a new account
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
Reattach to geth and see the new account: 
```
geth --datadir /home/ubuntu/ethereum/ethdata attach
prim = eth.accounts[0];
user2 = eth.accounts[1];
```
Show that User2 doesn't have any ethereum:
```
web3.fromWei(eth.getBalance(user2), 'ether');
web3.fromWei(eth.getBalance(prim), 'ether');
```


