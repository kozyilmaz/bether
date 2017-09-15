
## Sending/Receiving Transactions

### Sending Ether between accounts
Send ether from ```geth```console
```js
> personal.unlockAccount(eth.coinbase)
Unlock account 0xffecc801c6eed3fbc45d69e3e12ad4d9660f0d30
Passphrase: 
true
> eth.sendTransaction({from:eth.coinbase, to: '0x55ac737cc9bc16ffd1af42e53ee1515e56b6a188', value: web3.toWei(12, "ether")})
"0xcc7d3b59540460e46755410c2ab12ecf56f64e1fe3e8b8ee79455fd8331f29e2"
```

Transaction ```tx```has been created and submitted for mining
```js
INFO [09-13|09:24:37] Submitted transaction                    fullhash=0xcc7d3b59540460e46755410c2ab12ecf56f64e1fe3e8b8ee79455fd8331f29e2 recipient=0x55ac737cc9bc16ffd1af42e53ee1515e56b6a18
```

Logs will show that transaction has been mined and account balance query from ```geth``` console will confirm
```js
INFO [09-13|12:28:51] Imported new chain segment               blocks=1 txs=1 mgas=0.021 elapsed=6.121ms  mgasps=3.431  number=73221 hash=4ad709…67384c
> eth.getBalance(eth.coinbase)
23989801182000000000
```
