
## Monitoring Private Ethereum Network

### Install requirements
```shell
$ sudo apt install -y npm
$ sudo apt install -y nodejs-legacy
```

### Install eth-netstats
[eth-netstats](https://github.com/cubedro/eth-netstats) is the tool providing a monitoring site (frontend) for private network stats

Build ```eth-netstats``` as follows
```shell
$ git clone https://github.com/cubedro/eth-netstats
$ cd eth-netstats
$ npm install
$ sudo npm install -g grunt-cli
$ grunt
```
Run ```eth-netstats``` as follows, for details check ```netstats.sh``` script
```shell
$ PORT=<chosen_port:default 3000> WS_SECRET=<chosen_secret> npm start
```
Monitoring page can be reached like below, no information is presented until ```eth-net-intelligence-api``` is run
```
http://localhost:3000
```

### Install eth-net-intelligence-api
[eth-net-intelligence-api](https://github.com/cubedro/eth-net-intelligence-api) contains processes that communicate with the ethereum client using RPC and push the data to the monitoring site via websockets.

Build ```eth-net-intelligence-api``` as follows
```shell
$ git clone https://github.com/cubedro/eth-net-intelligence-api
$ cd eth-net-intelligence-api
$ npm install
$ sudo npm install -g pm2
```
Run ```eth-net-intelligence-api``` as follows, for details check ```netintapi.sh``` script and ```app.json``` files under ```config``` directory
```shell
$ pm2 start ./app.json
```
To check logs
```shell
$ pm2 logs node-app
```
To stop
```shell
$ pm2 stop ./app.json
```
