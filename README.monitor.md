
## Monitoring Private Ethereum Network

### Install requirements
```
$ sudo apt install -y npm
$ sudo apt install -y nodejs-legacy
```

### Install eth-netstats
[eth-netstats](https://github.com/cubedro/eth-netstats) is the tool providing a monitoring site (frontend) for private network stats

Build ```eth-netstats``` as follows
```
$ git clone https://github.com/cubedro/eth-netstats
$ cd eth-netstats
$ npm install
$ sudo npm install -g grunt-cli
$ grunt
```
Run ```eth-netstats``` as follows, for details check ```netstats.sh``` script
```
$ WS_SECRET=<chosen_secret> npm start
```

### Install eth-net-intelligence-api
[eth-net-intelligence-api](https://github.com/cubedro/eth-net-intelligence-api) contains processes that communicate with the ethereum client using RPC and push the data to the monitoring site via websockets.

Build ```eth-net-intelligence-api``` as follows
```
$ git clone https://github.com/cubedro/eth-net-intelligence-api
$ cd eth-net-intelligence-api
$ npm install
$ sudo npm install -g pm2
```
Run ```eth-net-intelligence-api``` as follows, for details check ```netintapi.sh``` script and ```app.json.*``` files
```
$ WS_SECRET=<chosen_secret> npm start
```
