#!/bin/sh

export BZZKEY=ffecc801c6eed3fbc45d69e3e12ad4d9660f0d30
echo -ne '\n' | swarm --bzzaccount $BZZKEY --datadir "~/bether" --ens-api "/root/bether/geth.ipc" --bzznetworkid 666 &
