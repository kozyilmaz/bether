## Private Ethereum Network

### Setup Node Zero
Create a new account for private net
```javascript
$ geth --datadir "~/bether" account new
```
Create a private chain with the custom genesis block
```javascript
$ geth --datadir "~/bether" init genesis.json
```
Launch node zero, a mining full node in cloud
```javascript
$ geth --rpc --rpcport "8000" --rpccorsdomain "*" --datadir "~/bether" --port "30303" --nodiscover --rpcapi "db,eth,net,web3" --identity "zero" --networkid 666 --mine --minerthreads 1 console
```
Execute command below for running for background (may also edit /etc/rc.local)
```javascript
$ nohup geth --rpc --rpcport "8000" --rpccorsdomain "*" --datadir "~/bether" --port "30303" --nodiscover --rpcapi "db,eth,net,web3" --identity "zero" --networkid 666 --mine --minerthreads 1 > /dev/null &
```
For attaching geth console
```javascript
$ geth --datadir "/root/bether" attach ipc:/root/bether/geth.ipc console
```

Run ```eth.getBalance(eth.coinbase)``` command to check the (pre-allocated) account balance  
Run ```admin.nodeInfo``` to get enode url (```enode://xxxxx```) and add ip address of the interface ```[::]``` to construct the complete enode address to share with other peers
```javascript
"enode://6ad5934db83a0266c4c6d5048d02f86b3e69251d45ad411387cde9cc5a86030f2bee4bcbe200d4238d91b01c94444e562986058c9c4acca2a92cb81eb012acfc@192.168.2.41:30303?discport=0"
```

### Setup Node One

Setup and launch node one, a non-mining full node
```javascript
$ geth --datadir "~/bether" account new
$ geth --datadir "~/bether" init genesis.json
$ geth --rpc --rpcport "8000" --rpccorsdomain "*" --datadir "~/bether" --port "30303" --nodiscover --rpcapi "db,eth,net,web3" --identity "one" --networkid 666 console
```

Run ```admin.addPeer``` to connect node zero
```javascript
> admin.addPeer("enode://6ad5934db83a0266c4c6d5048d02f86b3e69251d45ad411387cde9cc5a86030f2bee4bcbe200d4238d91b01c94444e562986058c9c4acca2a92cb81eb012acfc@192.168.2.41:30303")
```
Or create a ```<datadir>/static-nodes.json``` file that has the following format
```javascript
[
  "enode://f4642fa65af50cfdea8fa7414a5def7bb7991478b768e296f5e4a54e8b995de102e0ceae2e826f293c481b5325f89be6d207b003382e18a8ecba66fbaf6416c0@33.4.2.1:30303",
  "enode://pubkey@ip:port"
]
````

Send ether from node zero to one using one's wallet address. Execute on node zero, do not forget mine transaction
```javascript
> personal.unlockAccount(eth.coinbase)
> eth.sendTransaction({from:eth.coinbase, to: '0xcb2a95f964acf8adee7fae30cf5dc6a3f5e14a5c', value: web3.toWei(.000000000001, "ether")})
> miner.start()
> miner.stop()
```

###### Sources
* [Ethereum Private Network](https://github.com/ethereum/go-ethereum/wiki/Private-network)
* [Creating a private chain/testnet](https://souptacular.gitbooks.io/ethereum-tutorials-and-tips-by-hudson/content/private-chain.html)  
* [Setting up private network or local cluster](https://github.com/ethereum/go-ethereum/wiki/Setting-up-private-network-or-local-cluster)  
* [Test networks](https://github.com/ethereum/homestead-guide/blob/master/source/network/test-networks.rst#id6)

