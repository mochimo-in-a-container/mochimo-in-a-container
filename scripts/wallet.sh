#!/bin/bash
cd mochi/bin

if [ ! -e wallet.wal ]; then
    info "No wallet found! Generating..."
    sleep 5
    ./wallet -n
fi

# TODO:
# mainnet servers are supposed to have IPs from 65.151.42.11 to 65.151.42.16, inclusive
#RAND=`shuf -i 11-16 -n 1`
#./wallet -a65.151.42.$RAND -v wallet.wal
# but as of 16-09-2018, only 65.151.42.11 seem to work
./wallet -a65.151.42.11 -p2095 -v wallet.wal