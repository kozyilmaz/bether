
## Deploying/Running Smart Contracts

### Deploying a smart contract
Use Ethereum Solidity online compiler (https://remix.ethereum.org/) to create a compiled contract.  
Click and get contract details using ```Contract details (bytecode, interface etc.)``` section.  
Copy content of ```Web3 deploy``` into a JavaScript file and copy it to the same directory ```geth``` is launched  
Push the compiled smart contract via ```geth```
```shell
> personal.unlockAccount(eth.coinbase)
Unlock account 0x55ac737cc9bc16ffd1af42e53ee1515e56b6a188
Passphrase: 
true
> loadScript('vendor.js');
INFO [09-13|12:21:14] Submitted contract creation              fullhash=0x5554e94ef64027b94a0aac2c74bf92557e38373bc64a359e4e8e0aa03a6c9c5d contract=0x46c8731c5df8d24d154be1bf73866c946519e38a
null [object Object]
true
```

Logs will show smart contract has been mined and it is ready to use
```shell
INFO [09-13|12:22:07] Imported new chain segment               blocks=1 txs=1 mgas=0.567 elapsed=6.000ms mgasps=94.427 number=73208 hash=7db483…f4caa7
null [object Object]
Contract mined! address: 0x46c8731c5df8d24d154be1bf73866c946519e38a transactionHash: 0x5554e94ef64027b94a0aac2c74bf92557e38373bc64a359e4e8e0aa03a6c9c5d
```

### Running smart contract functions
