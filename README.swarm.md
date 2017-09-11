## Private Swarm Network

### Setup Swarm Node Zero
Create the first swarm node which will be used as a bootnode, use a valid wallet address as ```BZZKEY``` created on the node
```javascript
$ export BZZKEY=ffecc801c6eed3fbc45d69e3e12ad4d9660f0d30
$ echo -ne '\n' | swarm --bzzaccount $BZZKEY --datadir "~/bether" --ens-api "/root/bether/geth.ipc" --bzznetworkid 666 &
```

### Setup Swarm Node One
Launch a second swarm node that use the first node as bootnode
```javascript
$ export BZZKEY=55ac737cc9bc16ffd1af42e53ee1515e56b6a188
$ swarm --bzzaccount $BZZKEY --datadir "~/bether" --ens-api "/home/loki/bether/geth.ipc" --bzznetworkid 666 --bootnodes "enode://21091bdbb66b87660edacb29e45a210b4391e5911ca4a2d13c4440c7136fae87be3e1a05ddd0b4c2dd1c737c0a558621f49c337b0102c9af1b4ab6bbce822632@67.207.75.210:30399"
```

Create and upload data to swarm filesystem, get hash value for corresponding file
```javascript
$ curl -H "Content-Type: text/plain" --data-binary "some-test-data-from-iot-devices" http://localhost:8500/bzz:/
4c07ae7f00d60e485ae08a5e9e394e7694df7d6026e74ae8923a7714559f6529
```
Verify contents of swarm file in any other node
```javascript
$ curl http://localhost:8500/bzz:/4c07ae7f00d60e485ae08a5e9e394e7694df7d6026e74ae8923a7714559f6529
some-test-data-from-iot-devices
```

###### Sources
* [Swarm Guide](http://swarm-guide.readthedocs.io/en/latest)

