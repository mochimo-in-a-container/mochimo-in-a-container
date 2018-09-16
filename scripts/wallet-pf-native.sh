#!/bin/bash
if [ ! -e pf-native ]; then
    warn "No portforwarder-rs binary found, building..."
    if [ ! -e portforwarder-rs ]; then
        git clone https://github.com/pzmarzly/portforwarder-rs portforwarder-rs --depth 1
    fi
    cd portforwarder-rs
    cargo build
    cd ..
    cp portforwarder-rs/target/debug/pf pf-native
    rm -rf portforwarder-rs
    rm -rf .cargo
fi

PF_BIN=pf-native
. ../scripts/wallet-pf.sh