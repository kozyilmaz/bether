
## Deploying/Running Smart Contracts

### Deploying a smart contract
Use Ethereum Solidity online compiler (https://remix.ethereum.org/) to create a compiled contract.  
Click and get contract details using ```Contract details (bytecode, interface etc.)``` section.  
Copy content of ```Web3 deploy``` into a JavaScript file and copy it to the same directory ```geth``` is launched  

A compiled smart contract Javascript will look like the sample below:
```js
var browser_vendor_sol_vendorContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"creator","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"get_device_count","outputs":[{"name":"count","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"device_id","type":"address"},{"name":"file_hash","type":"bytes32"}],"name":"push_device_data","outputs":[{"name":"index","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"device_id","type":"address"}],"name":"get_device_data","outputs":[{"name":"data","type":"bytes32"},{"name":"index","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"device_id","type":"address"}],"name":"is_device_present","outputs":[{"name":"result","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"index","type":"uint256"}],"name":"get_device_at_index","outputs":[{"name":"device_address","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]);
var browser_vendor_sol_vendor = browser_vendor_sol_vendorContract.new(
   {
     from: web3.eth.accounts[0], 
     data: '0x6060604052341561000f57600080fd5b5b336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505b5b610730806100616000396000f30060606040523615610081576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806302d05d3f14610086578063076a881d146100db5780632023d0781461010457806341c0e1b51461015e578063ac5c8f6b14610173578063f42eb0e5146101cf578063fc59fc3314610220575b600080fd5b341561009157600080fd5b610099610283565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b34156100e657600080fd5b6100ee6102a8565b6040518082815260200191505060405180910390f35b341561010f57600080fd5b610148600480803573ffffffffffffffffffffffffffffffffffffffff16906020019091908035600019169060200190919050506102b6565b6040518082815260200191505060405180910390f35b341561016957600080fd5b610171610469565b005b341561017e57600080fd5b6101aa600480803573ffffffffffffffffffffffffffffffffffffffff169060200190919050506104fb565b6040518083600019166000191681526020018281526020019250505060405180910390f35b34156101da57600080fd5b610206600480803573ffffffffffffffffffffffffffffffffffffffff169060200190919050506105a1565b604051808215151515815260200191505060405180910390f35b341561022b57600080fd5b610241600480803590602001909190505061066d565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600060028054905090505b90565b60006102c1836105a1565b1561035b5781600160008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000018160001916905550600160008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600101549050610463565b81600160008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000181600019169055506001600280548060010182816103bc91906106b3565b916000526020600020900160005b86909190916101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555003600160008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600101819055506001600280549050039050610463565b5b92915050565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614156104f8576000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16ff5b5b565b600080610507836105a1565b1561051157600080fd5b600160008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000154600160008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060010154915091505b915091565b60008060028054905014156105b95760009050610668565b8173ffffffffffffffffffffffffffffffffffffffff166002600160008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206001015481548110151561062157fe5b906000526020600020900160005b9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff161490505b919050565b600060028281548110151561067e57fe5b906000526020600020900160005b9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690505b919050565b8154818355818115116106da578183600052602060002091820191016106d991906106df565b5b505050565b61070191905b808211156106fd5760008160009055506001016106e5565b5090565b905600a165627a7a723058205bf9825e4db183931c1094de34c126e278a1ed808017b3eecbd4a78c564a13550029', 
     gas: '4300000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
```

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
After smart contract is deployed, contract variable in generated JavaScript file can be used to list ```ABI``` and ```address``` of that specific contract
```js
> browser_vendor_sol_vendor
{
  abi: [{
      constant: true,
      inputs: [],
      name: "get_device_count",
      outputs: [{...}],
      payable: false,
      stateMutability: "view",
      type: "function"
  }, {
      constant: false,
      inputs: [],
      name: "kill",
      outputs: [],
      payable: false,
      stateMutability: "nonpayable",
      type: "function"
  }, {
      constant: true,
      inputs: [{...}],
      name: "get_device_timestamps",
      outputs: [{...}],
      payable: false,
      stateMutability: "view",
      type: "function"
  }, {
      constant: false,
      inputs: [{...}, {...}],
      name: "set_device_data",
      outputs: [{...}, {...}],
      payable: false,
      stateMutability: "nonpayable",
      type: "function"
  }, {
      constant: true,
      inputs: [{...}],
      name: "is_device_present",
      outputs: [{...}],
      payable: false,
      stateMutability: "view",
      type: "function"
  }, {
      constant: true,
      inputs: [{...}, {...}],
      name: "get_device_data",
      outputs: [{...}],
      payable: false,
      stateMutability: "view",
      type: "function"
  }, {
      constant: true,
      inputs: [{...}],
      name: "get_device_at_index",
      outputs: [{...}],
      payable: false,
      stateMutability: "view",
      type: "function"
  }, {
      inputs: [],
      payable: false,
      stateMutability: "nonpayable",
      type: "constructor"
  }, {
      anonymous: false,
      inputs: [{...}, {...}, {...}, {...}],
      name: "log_action",
      type: "event"
  }],
  address: "0x685b54259740628eb5529b36a7a31af65c8e99f2",
  transactionHash: "0x355a407c45da208ca8ee1a438ec96fdb17803528bab7c6c48ab81dc07a75ba3e",
  allEvents: function(),
  get_device_at_index: function(),
  get_device_count: function(),
  get_device_data: function(),
  get_device_timestamps: function(),
  is_device_present: function(),
  kill: function(),
  log_action: function(),
  set_device_data: function()
}
```
