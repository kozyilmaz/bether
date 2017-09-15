
## Generic IoT backend with a smart contract

### Deploying vendor smart contract
Deploy ```vendor``` smart contract to Ethereum network (```personal.unlockAccount(eth.coinbase)``` may be needed!)
```js
> loadScript('vendor.js');
INFO [09-15|16:32:46] Submitted contract creation              fullhash=0x7b9bcb221d4dc1aeedc7aef2df051a8a9b31bb43a0be90e1337fa0c9aedc4acd contract=0x8cc8d623b2b646cd84f8af6a8676ab01f3c4ba69
null [object Object]
true
> 
INFO [09-15|16:32:56] Imported new chain segment               blocks=1 txs=1 mgas=1.188 elapsed=5.131ms  mgasps=231.399 number=86496 hash=2fe10d…e2ab03
null [object Object]
Contract mined! address: 0x8cc8d623b2b646cd84f8af6a8676ab01f3c4ba69 transactionHash: 0x7b9bcb221d4dc1aeedc7aef2df051a8a9b31bb43a0be90e1337fa0c9aedc4acd
```

Check if any IoT device is registered or pushed data
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
INFO [09-15|16:33:16] Submitted transaction                    fullhash=0xde9a27763cd107076689fccc6bed8da4ca0ae424a6152b07a146eeff381129d4 recipient=0x8cc8d623b2b646cd84f8af6a8676ab01f3c4ba69
"0xde9a27763cd107076689fccc6bed8da4ca0ae424a6152b07a146eeff381129d4"
> 
> browser_vendor_sol_vendor.set_device_data('0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30', '07db3c1a5ec6bb5eebc7f0f85bc7061db15305f8845a19b59286c9b4cc225551', {from: eth.coinbase, gas: 500000});
INFO [09-15|16:33:41] Submitted transaction                    fullhash=0x7381fac5cd6ee2f5a9540b66bbbae3839f6e0ad1d618ec68c36e34f2ea307317 recipient=0x8cc8d623b2b646cd84f8af6a8676ab01f3c4ba69
"0x7381fac5cd6ee2f5a9540b66bbbae3839f6e0ad1d618ec68c36e34f2ea307317"
> 
INFO [09-15|16:33:47] Imported new chain segment               blocks=1 txs=1 mgas=0.176 elapsed=5.332ms  mgasps=33.063  number=86499 hash=f80be2…4a61a6
INFO [09-15|16:33:58] Imported new chain segment               blocks=1 txs=1 mgas=0.177 elapsed=6.382ms  mgasps=27.753  number=86501 hash=e4fab9…5684d0
```

Force two transactions to push multiple file hashes into a single block (same ```block.timestamp``` or ```now```)
```js
> browser_vendor_sol_vendor.set_device_data(eth.coinbase, '9beba93cfa7c97d64b81c9a459e59c457794385006c2a71a1b41a6c3a64875f8', {from: eth.coinbase, gas: 500000});
INFO [09-15|16:34:02] Submitted transaction                    fullhash=0x1e6083310acc1f90bcbccf614a0e34f489c6c72b284b0a1b3b2f8c7603c2dcf0 recipient=0x8cc8d623b2b646cd84f8af6a8676ab01f3c4ba69
"0x1e6083310acc1f90bcbccf614a0e34f489c6c72b284b0a1b3b2f8c7603c2dcf0"
> browser_vendor_sol_vendor.set_device_data(eth.coinbase, '0e1b17b6c63d2b49e715d3ea8858506d2e079ac97d18663c7ca35b0b5512ace9', {from: eth.coinbase, gas: 500000});
INFO [09-15|16:34:02] Submitted transaction                    fullhash=0x13497ab67aaaeefe11d02f0465a60b84633f0cd1aae5eba71e7b5c8d9857d145 recipient=0x8cc8d623b2b646cd84f8af6a8676ab01f3c4ba69
"0x13497ab67aaaeefe11d02f0465a60b84633f0cd1aae5eba71e7b5c8d9857d145"
> 
INFO [09-15|16:34:21] Imported new chain segment               blocks=1 txs=2 mgas=0.257 elapsed=7.913ms  mgasps=32.453  number=86503 hash=1a92b5…95e516
```

Send another file handle
```js
> browser_vendor_sol_vendor.set_device_data('0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30', 'a56c2b63d830363c18dbaae7388387511d96e3e129f6693a280ef7efb6265a51', {from: eth.coinbase, gas: 500000});
INFO [09-15|16:34:26] Submitted transaction                    fullhash=0x6aa978a4109b2d00c68aadcd66e02bc54ec923081f991e485c9263f3f6c7f9e9 recipient=0x8cc8d623b2b646cd84f8af6a8676ab01f3c4ba69
"0x6aa978a4109b2d00c68aadcd66e02bc54ec923081f991e485c9263f3f6c7f9e9"
> 
INFO [09-15|16:34:40] Imported new chain segment               blocks=1 txs=1 mgas=0.117 elapsed=6.818ms  mgasps=17.216  number=86505 hash=491c3e…77a88c
```

Check how many devices are registered
```js
> browser_vendor_sol_vendor.get_device_count();
2
```

Check timestamps and contents of received data (first device)
```js
> browser_vendor_sol_vendor.get_device_timestamps(eth.coinbase);
[1505482411, 1505482460]
>
> browser_vendor_sol_vendor.get_device_data(eth.coinbase, 1505482411);
"44309aed2f2be69a23fa4747a950c266a79d0444efe7f74d8f358646f6ad8894"
> 
> browser_vendor_sol_vendor.get_device_data(eth.coinbase, 1505482460);
"9beba93cfa7c97d64b81c9a459e59c457794385006c2a71a1b41a6c3a64875f8,0e1b17b6c63d2b49e715d3ea8858506d2e079ac97d18663c7ca35b0b5512ace9"
```

Check timestamps and contents of received data (second device)
```js
> browser_vendor_sol_vendor.get_device_timestamps('0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30');
[1505482428, 1505482469]
> 
> browser_vendor_sol_vendor.get_device_data('0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30',1505482428);
"07db3c1a5ec6bb5eebc7f0f85bc7061db15305f8845a19b59286c9b4cc225551"
> 
> browser_vendor_sol_vendor.get_device_data('0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30',1505482469);
"a56c2b63d830363c18dbaae7388387511d96e3e129f6693a280ef7efb6265a51"
```

Check contents of the received file handles
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
