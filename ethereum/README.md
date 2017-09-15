
## Generic IoT backend with a smart contract

### API
```shell
function is_device_present (address device_id) public constant returns (bool result);
function get_device_count() public constant returns (uint count);
function get_device_at_index (uint index) public constant returns (address device_address);
function get_device_timestamps (address device_id) public constant returns (uint[] timestamp);
function get_device_data (address device_id, uint timestamp) public constant returns (string hash);
function set_device_data (address device_id, string filehash) public returns (uint index, uint timestamp);
# event to log action
event log_action (address indexed device_id, uint index, uint timestamp, string filehash);
```

### Deploying vendor smart contract
Deploy ```vendor``` smart contract (and ```event``` listener) to Ethereum network
```js
> personal.unlockAccount(eth.coinbase);
Unlock account 0x55ac737cc9bc16ffd1af42e53ee1515e56b6a188
Passphrase: 
true
> 
> loadScript('vendor.js');
INFO [09-15|22:30:39] Submitted contract creation              fullhash=0xe1cac4360ae2e03708d5b56857432a8352ba362a62aca1e8b643da6a2a38837e contract=0x353ef87ff272733c0acd23540d2b2c8e4a9c0d63
null [object Object]
true
> 
INFO [09-15|22:31:09] Imported new chain segment               blocks=1 txs=1 mgas=1.312 elapsed=6.243ms  mgasps=210.146 number=88029 hash=4e28ea…092106
null [object Object]
Contract mined! address: 0x353ef87ff272733c0acd23540d2b2c8e4a9c0d63 transactionHash: 0xe1cac4360ae2e03708d5b56857432a8352ba362a62aca1e8b643da6a2a38837e
>
> loadScript('event.js');
true
```

Check if any IoT device is registered or ever pushed data
```js
> browser_vendor_sol_vendor.get_device_count();
0
```

### Sending IoT data to swarm
Start sending data to ```swarm``` filesystem and get file hashes (handles). In this IoT backend scenario ```swarm``` system will be used as file storage and Ethereum blockchain as a file explorer 
```js
$ curl -H "Content-Type: text/plain" --data-binary '{ "timestamp": "1505477559", "payload": "hello from IoT device!" }' http://localhost:8500/bzz:/
44309aed2f2be69a23fa4747a950c266a79d0444efe7f74d8f358646f6ad8894
$ curl -H "Content-Type: text/plain" --data-binary '{ "timestamp": "1505477600", "payload": "lets throw another IoT device in the mix" }' http://localhost:8500/bzz:/
07db3c1a5ec6bb5eebc7f0f85bc7061db15305f8845a19b59286c9b4cc225551
$ curl -H "Content-Type: text/plain" --data-binary '{ "timestamp": "1505477700", "payload": "IoT device talking still" }' http://localhost:8500/bzz:/
9beba93cfa7c97d64b81c9a459e59c457794385006c2a71a1b41a6c3a64875f8
$ curl -H "Content-Type: text/plain" --data-binary '{ "timestamp": "1505477750", "payload": "IoT device end of talk!" }' http://localhost:8500/bzz:/
0e1b17b6c63d2b49e715d3ea8858506d2e079ac97d18663c7ca35b0b5512ace9
$ curl -H "Content-Type: text/plain" --data-binary '{ "timestamp": "1505477820", "payload": "bye from other IoT device" }' http://localhost:8500/bzz:/
a56c2b63d830363c18dbaae7388387511d96e3e129f6693a280ef7efb6265a51 
```

### Tracking data via Ethereum blockchain
Send ```swarm``` file hashes (handles) of uploaded files to Ethereum via smart contract
```js
> browser_vendor_sol_vendor.set_device_data(eth.coinbase, '44309aed2f2be69a23fa4747a950c266a79d0444efe7f74d8f358646f6ad8894', {from: eth.coinbase, gas: 500000});
INFO [09-15|22:31:39] Submitted transaction                    fullhash=0x7f17070b6c129af55bc1f6f2e5db01a7a74bc143f09b41dc349ff9e5ab485cfb recipient=0x353ef87ff272733c0acd23540d2b2c8e4a9c0d63
"0x7f17070b6c129af55bc1f6f2e5db01a7a74bc143f09b41dc349ff9e5ab485cfb"
> 
> browser_vendor_sol_vendor.set_device_data('0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30', '07db3c1a5ec6bb5eebc7f0f85bc7061db15305f8845a19b59286c9b4cc225551', {from: eth.coinbase, gas: 500000});
INFO [09-15|22:32:00] Submitted transaction                    fullhash=0xce55e21ebd613fc64571e34cfe76cf026e2d99d1ead9246daacc11b7ac932bae recipient=0x353ef87ff272733c0acd23540d2b2c8e4a9c0d63
"0xce55e21ebd613fc64571e34cfe76cf026e2d99d1ead9246daacc11b7ac932bae"
> 
INFO [09-15|22:32:05] Imported new chain segment               blocks=1 txs=1 mgas=0.180 elapsed=6.345ms  mgasps=28.302  number=88035 hash=fba085…e51ca3
DEV[0x55ac737cc9bc16ffd1af42e53ee1515e56b6a188] INDEX[0] TIME[1505503913] HASH[44309aed2f2be69a23fa4747a950c266a79d0444efe7f74d8f358646f6ad8894]
INFO [09-15|22:32:36] Imported new chain segment               blocks=1 txs=1 mgas=0.180 elapsed=6.616ms  mgasps=27.270  number=88037 hash=28aeb0…f0a9a2
DEV[0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30] INDEX[1] TIME[1505503925] HASH[07db3c1a5ec6bb5eebc7f0f85bc7061db15305f8845a19b59286c9b4cc225551]
```

Force two transactions to push multiple file hashes into a single block (same ```block.timestamp``` or ```now```)
```js
> browser_vendor_sol_vendor.set_device_data(eth.coinbase, '9beba93cfa7c97d64b81c9a459e59c457794385006c2a71a1b41a6c3a64875f8', {from: eth.coinbase, gas: 500000});
INFO [09-15|22:32:43] Submitted transaction                    fullhash=0x1dc54a9fa237691943f5d1c457fbfc6886be0032c7ba54cb2777d9e4c849eff8 recipient=0x353ef87ff272733c0acd23540d2b2c8e4a9c0d63
"0x1dc54a9fa237691943f5d1c457fbfc6886be0032c7ba54cb2777d9e4c849eff8"
> browser_vendor_sol_vendor.set_device_data(eth.coinbase, '0e1b17b6c63d2b49e715d3ea8858506d2e079ac97d18663c7ca35b0b5512ace9', {from: eth.coinbase, gas: 500000});
INFO [09-15|22:32:44] Submitted transaction                    fullhash=0xd361ce246a3d956030898f1bd1e51d94ab62c4a59deabd27470a53d7eca41a64 recipient=0x353ef87ff272733c0acd23540d2b2c8e4a9c0d63
"0xd361ce246a3d956030898f1bd1e51d94ab62c4a59deabd27470a53d7eca41a64"
> 
INFO [09-15|22:33:21] Imported new chain segment               blocks=1 txs=2 mgas=0.264 elapsed=10.692ms mgasps=24.651  number=88041 hash=d8242d…2b8e78
DEV[0x55ac737cc9bc16ffd1af42e53ee1515e56b6a188] INDEX[0] TIME[1505503986] HASH[9beba93cfa7c97d64b81c9a459e59c457794385006c2a71a1b41a6c3a64875f8]
DEV[0x55ac737cc9bc16ffd1af42e53ee1515e56b6a188] INDEX[0] TIME[1505503986] HASH[0e1b17b6c63d2b49e715d3ea8858506d2e079ac97d18663c7ca35b0b5512ace9]
```

Send another file handle
```js
> browser_vendor_sol_vendor.set_device_data('0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30', 'a56c2b63d830363c18dbaae7388387511d96e3e129f6693a280ef7efb6265a51', {from: eth.coinbase, gas: 500000});
INFO [09-15|22:33:26] Submitted transaction                    fullhash=0xcbdb05266990420962b7eec5ad327f759380396cfee6f5d163e4c70cd7e22c99 recipient=0x353ef87ff272733c0acd23540d2b2c8e4a9c0d63
"0xcbdb05266990420962b7eec5ad327f759380396cfee6f5d163e4c70cd7e22c99"
> 
INFO [09-15|22:33:56] Imported new chain segment               blocks=1 txs=1 mgas=0.121 elapsed=5.731ms  mgasps=21.069  number=88044 hash=ea2e8d…8f30bf
DEV[0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30] INDEX[1] TIME[1505504010] HASH[a56c2b63d830363c18dbaae7388387511d96e3e129f6693a280ef7efb6265a51]
```

Check how many devices are registered
```js
> browser_vendor_sol_vendor.get_device_count();
2
```

### Querying IoT backend and reaching stored data via Ethereum
Check timestamps and contents of received data (first device)
```js
> browser_vendor_sol_vendor.get_device_timestamps(eth.coinbase);
[1505503913, 1505503986]
> 
> browser_vendor_sol_vendor.get_device_data(eth.coinbase, 1505503913);
"44309aed2f2be69a23fa4747a950c266a79d0444efe7f74d8f358646f6ad8894"
> 
> browser_vendor_sol_vendor.get_device_data(eth.coinbase, 1505503986);
"9beba93cfa7c97d64b81c9a459e59c457794385006c2a71a1b41a6c3a64875f8,0e1b17b6c63d2b49e715d3ea8858506d2e079ac97d18663c7ca35b0b5512ace9"
```

Check timestamps and contents of received data (second device)
```js
> browser_vendor_sol_vendor.get_device_timestamps('0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30');
[1505503925, 1505504010]
> 
> browser_vendor_sol_vendor.get_device_data('0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30',1505503925);
"07db3c1a5ec6bb5eebc7f0f85bc7061db15305f8845a19b59286c9b4cc225551"
> 
> browser_vendor_sol_vendor.get_device_data('0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30',1505504010);
"a56c2b63d830363c18dbaae7388387511d96e3e129f6693a280ef7efb6265a51"
```

Look into ```swarm``` handles received via Ethereum blockchain
```js
$ curl -s http://localhost:8500/bzz:/44309aed2f2be69a23fa4747a950c266a79d0444efe7f74d8f358646f6ad8894
{ "timestamp": "1505477559", "payload": "hello from IoT device!" }
$ curl -s http://localhost:8500/bzz:/9beba93cfa7c97d64b81c9a459e59c457794385006c2a71a1b41a6c3a64875f8
{ "timestamp": "1505477700", "payload": "IoT device talking still" }
$ curl -s http://localhost:8500/bzz:/0e1b17b6c63d2b49e715d3ea8858506d2e079ac97d18663c7ca35b0b5512ace9
{ "timestamp": "1505477750", "payload": "IoT device end of talk!" }
$ curl -s http://localhost:8500/bzz:/07db3c1a5ec6bb5eebc7f0f85bc7061db15305f8845a19b59286c9b4cc225551
{ "timestamp": "1505477600", "payload": "lets throw another IoT device in the mix" }
$ curl -s http://localhost:8500/bzz:/a56c2b63d830363c18dbaae7388387511d96e3e129f6693a280ef7efb6265a51
{ "timestamp": "1505477600", "payload": "bye from other IoT device" }
```
