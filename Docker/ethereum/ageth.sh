#! /bin/bash

#NODELIST='node1 node2 node3'
#EBASE=''
#BOOTNODES=''
#IPCAPI='admin,db,eth,debug,miner,net,shh,txpool,personal,web3'
IPCDISABLED='--ipcdisable'
RPCAPI='db,eth,net,web3'
RPCADDR='0.0.0.0'
RPCPORT='8545'
NETID='3435'
GETPORT='30301'
#RPCDOMAIN='*'

EBASE1='0e7ea46fbf83ddd5b3bb330853d9ba7085a2c51e'
EBASE2='70029349c2b6127700010e99a67b2b3177dc8e4d'
EBASE3='b8539bf6887e37611246990769dcc78b347136be'
ENODE1='enode://8e8ec00f721cb2210630b19e722c5c0f1525ca2962c92f8325dcdfc82096bc6b2752be7d56d750cd71c6dffd4a129022b3a94ee9b1b66219aab29e18e7148558@128.107.34.40:30301'
ENODE2='enode://bbbd44fdcdab056170bd99c82622455b3d4d63dee180866e624c119bbea18cd79d5d086ebab843b64e2d3ab790798fd6337fdae15b2b37bb93eb8962dee13653@128.107.34.41:30301'
ENODE3='enode://8c3527ebfefea1f92a5fc0559579a94b79f02fdaabcca4e98a367234133dc1306d6f450792bb59af5407bc0c355119c6cb112e04a66147c1e8e952276b62daad@128.107.34.44:30301'

LOG_FILE='~/eth/logs/00.log'
GEN_BLOCK='genesis_block_test.json'
DATA_DIR='~/.ethereum/'

[ $# -lt 1 ] && echo "uses: ./aget.sh <node_name>" && exit 0
#echo -n 1
[[ $NODELIST =~ $1 ]] && echo "" ||  echo "error: not a valid node name (supported name: $NODELIST)"
[[ $NODELIST =~ $1 ]] && echo "" ||  exit 0
#echo -n 2
[ "node1" == "$1" ] && EBASE=$EBASE1 && BOOTNODES="$ENODE2 $ENODE3"
[ "node2" == "$1" ] && EBASE=$EBASE2 && BOOTNODES="$ENODE1 $ENODE3"
[ "node3" == "$1" ] && EBASE=$EBASE3 && BOOTNODES="$ENODE1 $ENODE2"
#echo $EBASE
#echo $BOOTNODES
GETH_COMMAND_IPC="/usr/bin/geth --genesis $GEN_BLOCK --bootnodes \"$BOOTNODES\"  --mine --minerthreads 1 --datadir $DATA_DIR --networkid $NETID $IPCDISABLED --ipcapi $IPCAPI --port $GETPORT --rpc --rpcaddr $RPCADDR --rpcport $RPCPORT --rpcapi $RPCAPI --rpccorsdomain $RPCDOMAIN --nodiscover --verbosity 6 --etherbase $EBASE 2>> $LOG_FILE"
GETH_COMMAND1="/usr/bin/geth --genesis $GEN_BLOCK --bootnodes \"$BOOTNODES\"  --mine --minerthreads 1 --datadir $DATA_DIR --networkid $NETID --ipcdisable $IPCAPI --port $GETPORT --rpc --rpcaddr $RPCADDR --rpcport $RPCPORT --rpcapi $RPCAPI"
GETH_COMMAND2="$RPCDOMAIN --nodiscover --verbosity 6 --etherbase $EBASE 2>> $LOG_FILE"

#echo -n $GETH_COMMAND1
#echo -n $GETH_COMMAND2

echo -n "Starting geth for Node: $1"
#echo "$GETH_COMMAND1 --rpccorsdomain * $GETH_COMMAND2"
screen -dmS geth /bin/bash -c "$GETH_COMMAND1 --rpccorsdomain * $GETH_COMMAND2"

#screen -dmS geth /bin/bash -c '/usr/bin/geth --genesis genesis_block_test.json --bootnodes "enode://bbbd44fdcdab056170bd99c82622455b3d4d63dee180866e624c119bbea18cd79d5d086ebab843b64e2d3ab790798fd6337fdae15b2b37bb93eb8962dee13653@128.107.34.41:30301"  --mine --minerthreads 1 --datadir ~/.ethereum/ --networkid 3435 --ipcdisable --port 30301 --rpc --rpcaddr 0.0.0.0 --rpcport 8110 --rpccorsdomain * --nodiscover --verbosity 6 --etherbase 0e7ea46fbf83ddd5b3bb330853d9ba7085a2c51e 2>> ~/eth/logs/00.log'
#screen -dmS geth /bin/bash -c '/usr/bin/geth --genesis genesis_block_test.json --bootnodes "enode://8e8ec00f721cb2210630b19e722c5c0f1525ca2962c92f8325dcdfc82096bc6b2752be7d56d750cd71c6dffd4a129022b3a94ee9b1b66219aab29e18e7148558@128.107.34.40:30301"  --mine --minerthreads 1 --datadir ~/.ethereum/ --networkid 3435 --ipcdisable --port 30301 --rpc --rpcaddr 0.0.0.0 --rpcport 8110 --rpccorsdomain * --nodiscover --verbosity 6 --etherbase 70029349c2b6127700010e99a67b2b3177dc8e4d 2>> ~/eth/logs/00.log'
#screen -dmS geth /bin/bash -c '/usr/bin/geth --genesis genesis_block_test.json --bootnodes "enode://8e8ec00f721cb2210630b19e722c5c0f1525ca2962c92f8325dcdfc82096bc6b2752be7d56d750cd71c6dffd4a129022b3a94ee9b1b66219aab29e18e7148558@128.107.34.40:30301 enode://bbbd44fdcdab056170bd99c82622455b3d4d63dee180866e624c119bbea18cd79d5d086ebab843b64e2d3ab790798fd6337fdae15b2b37bb93eb8962dee13653@128.107.34.41:30301"  --mine --minerthreads 2 --datadir ~/.ethereum/ --networkid 3435 --ipcdisable --port 30301 --rpc --rpcaddr 0.0.0.0 --rpcport 8110 --rpccorsdomain * --nodiscover --verbosity 6 --etherbase b8539bf6887e37611246990769dcc78b347136be 2>> ~/eth/logs/00.log'
#screen -dmS geth /bin/bash -c '/usr/bin/geth --genesis genesis_block_test.json --bootnodes "enode://8e8ec00f721cb2210630b19e722c5c0f1525ca2962c92f8325dcdfc82096bc6b2752be7d56d750cd71c6dffd4a129022b3a94ee9b1b66219aab29e18e7148558@128.107.34.40:30301 enode://8c3527ebfefea1f92a5fc0559579a94b79f02fdaabcca4e98a367234133dc1306d6f450792bb59af5407bc0c355119c6cb112e04a66147c1e8e952276b62daad@128.107.34.44:30301"  --mine --minerthreads 1 --datadir ~/.ethereum/ --networkid 3435 --ipcdisable --port 30301 --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpccorsdomain * --nodiscover --verbosity 6 --etherbase 70029349c2b6127700010e99a67b2b3177dc8e4d 2>> ~/eth/logs/00.log'
#screen -dmS geth /bin/bash -c '/usr/bin/geth --genesis genesis_block_test.json --bootnodes "enode://bbbd44fdcdab056170bd99c82622455b3d4d63dee180866e624c119bbea18cd79d5d086ebab843b64e2d3ab790798fd6337fdae15b2b37bb93eb8962dee13653@128.107.34.41:30301 enode://8c3527ebfefea1f92a5fc0559579a94b79f02fdaabcca4e98a367234133dc1306d6f450792bb59af5407bc0c355119c6cb112e04a66147c1e8e952276b62daad@128.107.34.44:30301"  --mine --minerthreads 1 --datadir ~/.ethereum/ --networkid 3435 --ipcdisable  --port 30301 --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpcapi db,eth,net,web3 --rpccorsdomain *  --nodiscover --verbosity 6 --etherbase 0e7ea46fbf83ddd5b3bb330853d9ba7085a2c51e 2>> ~/eth/logs/00.log'

#sudo apt-get update && sudo apt-get install screen -y
#Then you can make a bash similar to this (~/geth.sh):
##!/usr/bin/env bash
#echo "Starting geth"
#screen -dmS geth /usr/bin/geth --verbosity 3
#geth attach
#You attach to the screen with screen -x geth
#You detach from the screen by pressing CTRL + a then d
#echo "Starting get_attachh"
#screen -dmS geth_attach /bin/bash -c 'geth attach rpc:http://localhost:8545'
#rm -r eth/
#mkdir -p ~/eth/data ~/eth/logs
#screen -dmS geth /usr/bin/geth --verbosity 3
#geth --genesis genesis_block_test.json --mine --minerthreads 1 --datadir ~/.ethereum/ --networkid 3435 --ipcdisable --port 30301 --rpcport 8110 --nodiscover --verbosity 4 --etherbase 0e7ea46fbf83ddd5b3bb330853d9ba7085a2c51e console 2>> ~/eth/logs/00.log
#geth --genesis genesis_block_test.json --mine --minerthreads 1 --datadir ~/.ethereum/ --networkid 3435 --ipcdisable --port 30301 --rpcport 8110 --nodiscover --maxpeers 1 --verbosity 6 --etherbase 0e7ea46fbf83ddd5b3bb330853d9ba7085a2c51e console 2>> ~/eth/logs/00.log
#geth --genesis genesis_block_test.json --mine --minerthreads 1 --datadir ~/.ethereum/ --networkid 3435 --ipcdisable --port 30301 --rpcport 8110 --nodiscover --verbosity 4 --etherbase 0e7ea46fbf83ddd5b3bb330853d9ba7085a2c51e console 2>> ~/eth/logs/00.log
#admin.addPeer('enode://8e8ec00f721cb2210630b19e722c5c0f1525ca2962c92f8325dcdfc82096bc6b2752be7d56d750cd71c6dffd4a129022b3a94ee9b1b66219aab29e18e7148558@128.107.34.40:30301')
#geth --genesis genesis_block_test.json --mine --minerthreads 1 --datadir ~/.ethereum/ --networkid 3435 --ipcdisable --port 30301 --rpcport 8545 --nodiscover --verbosity 4 --etherbase b8539bf6887e37611246990769dcc78b347136be console 2>> ~/eth/logs/00.log
#BOOTNODES='enode://8e8ec00f721cb2210630b19e722c5c0f1525ca2962c92f8325dcdfc82096bc6b2752be7d56d750cd71c6dffd4a129022b3a94ee9b1b66219aab29e18e7148558@128.107.34.40:30301'
#screen -dmS geth /bin/bash -c '/usr/bin/geth --genesis genesis_block_test.json --bootnodes "enode://8e8ec00f721cb2210630b19e722c5c0f1525ca2962c92f8325dcdfc82096bc6b2752be7d56d750cd71c6dffd4a129022b3a94ee9b1b66219aab29e18e7148558@128.107.34.40:30301"  --mine --minerthreads 1 --datadir ~/.ethereum/ --networkid 3435 --ipcdisable --port 30301 --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpccorsdomain * --nodiscover --verbosity 6 --etherbase 70029349c2b6127700010e99a67b2b3177dc8e4d 2>> ~/eth/logs/00.log'
