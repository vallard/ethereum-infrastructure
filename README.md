# Private Ethereum setup 

Purpose is to run Ethereum in containers on a private network. 

## Instructions

### Step 1: Packer

Go to the Packer directory and run: 
```
packer build ethereum.json
```
This will (hopefully) build an image in your environment.  The assumptions are: 
* That you have a CoreOS image
* That you are running on OpenStack (or Metapod)

For this to work, you will probably have to change some parameters in the 
builders section.  You will have to modify:
  * Source Image (This should be CoreOS)
  * Networks (This should be the network you're attaching to)
  * Flavor (run ```nova flavor-list``` to see what you have)  Mine is using about 4GB of RAM and 50 GB of ephemeral storage, but could be less.  10 should be fine or smaller if you have a volume and you want to persist your ethers. 
 
Packer seems to have a bug with OpenStack and private keys.  It's supposed to generate it's own keypair when it runs but this seems to cause errors.  To get around this I have provided the packerKey files that you can use.  Since this is just a temporary key for building the image, you can probably use it without fear.  

### Step 2: Terraform

If Packer built the image correctly then you can head over to the Terraform directory and provision some nodes that will automatically start mining. 

```
cd ../Terraform
terraform plan # check for errors
terraform apply
```

The same assumptions go for Terraform as for Packer.  We're assuming you're on OpenStack using CoreOS. There are several variables at the top of the file that you should probably change to match your environment.  Use ```cis.tf``` as an example. 

The ```startmining.sh``` script is executed when the node launches and should bring up two ethereum containers.  These containers will instantly start building a DAG and start mining.  The container images all have the same private key installed as well, so all the miners will work for your good. 

That's pretty much all there is to this repository.  If you have questions I'm happy to answer them as best I can. 

## Docker Info

The docker image that is used by the packer and terraform config tools
can be use like 
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
[Follow these instructions](https://github.com/ethereum/go-ethereum/wiki/Contracts-and-Transactions#testing-contracts-and-transactions)
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


## Documentation References

Trying to build this workflow was pretty difficult but there were some
good places that I got information from. 

Great document on starting a private chain:
http://adeduke.com/2015/08/how-to-create-a-private-ethereum-chain/

But this one might be a little more explicit:
http://tech.lab.carl.pro/kb/ethereum/testnet_setup

Instructions to get up and running and mine to do contracts: 
https://github.com/ethereum/go-ethereum/wiki/Contracts-and-Transactions#testing-contracts-and-transactions

Allocating balance at startup:
https://gist.github.com/maran/8c58a65df3c3a4548ae6

