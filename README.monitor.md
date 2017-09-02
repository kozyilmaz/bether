
## Monitoring Private Ethereum Network

### Install eth-netstats
[eth-netstats](https://github.com/cubedro/eth-netstats) is the tool providing a monitoring site (frontend) for private network stats

Install requirements
```
$ sudo apt install -y npm
$ sudo apt install -y nodejs-legacy
```
Install and run ```eth-netstats```, for details check ```netstats.sh``` script
```
$ git clone https://github.com/cubedro/eth-netstats
$ cd eth-netstats
$ npm install
$ sudo npm install -g grunt-cli
$ grunt
$ WS_SECRET=<chosen_secret> npm start
```

### Build Ethereum Client
```
$ git clone https://github.com/ethereum/go-ethereum.git
$ cd go-ethereum
$ git checkout v1.6.7
$ make geth
$ sudo cp build/bin/geth /usr/local/bin/geth
```
