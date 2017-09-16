# IoT backend with Swarm and Ethereum smart contracts

![Bether](https://github.com/kozyilmaz/bether/raw/master/readme/ethstats.png "Proof-of-concept IoT backend")

### Using Ethereum + Swarm as an IoT backend
* IoT gateways, which are relatively powerful LoRa/NB-IoT devices, may be used to push collected data to torrent-like ```Swarm``` file storage network via HTTP.
* Created file handles are stored in ```Ethereum``` blockchain using a smart contract named [vendor.sol](ethereum/vendor.sol).
* By using ```Swarm``` as the storage service  and ```Ethereum``` blockchain as the file explorer, it is possible to create a generic backend for IoT device manufacturers.

### Smart contract interface
```shell
# check if device is present i.e. has ever pushed any data
function is_device_present (address device_id) public constant returns (bool result);
# get total device count
function get_device_count() public constant returns (uint count);
# enumerate device id's
function get_device_at_index (uint index) public constant returns (address device_address);
# get timestamp values containing data (for a specific device)
function get_device_timestamps (address device_id) public constant returns (uint[] timestamp);
# get stored file hashes (handles) with certain timestamp (for a specific device)
function get_device_data (address device_id, uint timestamp) public constant returns (string hash);
# push file hashes (handles) into the chain
function set_device_data (address device_id, string filehash) public returns (uint index, uint timestamp);
# event to log action
event log_action (address indexed device_id, uint index, uint timestamp, string filehash);
```
* [How to deploy and run 'vendor' smart contract](ethereum/README.md)

### Complete setup guide
* [How to build Ethereum and Swarm binaries?](readme/README.build.md)
* [What is Genesis block?](readme/README.genesis.md)
* [How to setup a private Ethereum network?](readme/README.network.md)
* [How to monitor the network?](readme/README.monitor.md)
* [How to make transactions?](readme/README.transaction.md)
* [How to start a private Swarm network?](readme/README.swarm.md)
* [How to run Solidity (Remix IDE)?](readme/README.solidity.md)
* [How to deploy and run smart contracts?](readme/README.smartcontracts.md)

