
## Install Ethereum

### Install Go
Download precompiled Go binaries from [official project site](https://golang.org/dl)

For x86_64 Linux
```
$ sudo apt install -y curl
$ sudo apt install -y build-essential
$ sudo apt install -y screen
$ curl -O https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz
```
For Raspberry Pi Linux
```
$ sudo apt install -y curl
$ sudo apt install -y build-essential
$ sudo apt install -y screen
$ curl -O https://storage.googleapis.com/golang/go1.9.linux-armv6l.tar.gz
```
Install Go binaries
```
$ sudo tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
```
Add path to /etc/profile (for a system-wide installation) or $HOME/.profile
```javascript
$ export PATH=$PATH:/usr/local/go/bin
$ sudo reboot
```

### Build Ethereum Client
```
$ git clone https://github.com/ethereum/go-ethereum.git
$ cd go-ethereum
$ git checkout v1.6.7
$ make geth
$ make swarm
$ sudo cp build/bin/geth /usr/local/bin/geth
$ sudo cp build/bin/swarm /usr/local/bin/swarm
```
