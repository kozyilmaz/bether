# Bether : IoT backend with an Ethereum smart contract

![Bether](https://github.com/kozyilmaz/bether/raw/master/readme/ethstats.png "Proof-of-concept IoT backend")

### Using Ethereum + Swarm as an IoT backend
* In this setup IoT gateways, which are relatively powerful LoRa/NB-IoT devices, are used to push collected data to a torrent-like file storage network named ```Swarm``` via HTTP.
* Created file handles are pushed into ```Ethereum``` via a smart contract named [vendor.sol](ethereum/vendor.sol).
* Using ```Swarm``` as a storage service  and ```blockchain``` as a file explorer makes it possible to use ```Ethereum + Swarm``` as the generic web backend for IoT device manufacturers.
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

