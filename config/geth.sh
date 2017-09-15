#!/bin/sh

screen -dmS geth /usr/local/bin/geth --rpc --rpcport "8000" --rpccorsdomain "*" --datadir "~/bether" --port "30303" --nodiscover --rpcapi "db,eth,net,web3" --identity "zero" --networkid 666 --mine --minerthreads 1 &
