#!/bin/bash
cd mochi/bin

if [ ! -e wallet.wal ]; then
    info "No wallet found! Generating..."
    sleep 5
    ./wallet -n
fi

./wallet -a65.151.42.11 -v wallet.wal