#!/bin/bash
mkdir -p installation
export HOME=/work/installation
cd

. ../scripts/_utils.sh

# first setup
if [ ! -e initdone ]
then
    warn "No installation of Mochimo client found, starting the installer"
    info "Using forks to pin versions"

    info "Asking for license agreements"
    echo "Link to Mochimo license: https://raw.githubusercontent.com/mochimo-in-a-container/mochimo/master/LICENSE.PDF"
    echo "Do you agree to Mochimo license?"
    user_agreement

    echo "Link to MochiToolkit license: https://raw.githubusercontent.com/mochimo-in-a-container/mochitoolkit/master/LICENSE"
    echo "Do you agree to MochiToolkit license?"
    user_agreement

    echo "Link to portforwarder-rs license: https://raw.githubusercontent.com/mochimo-in-a-container/portforwarder-rs/master/LICENSE"
    echo "Do you agree to portforwarder-rs license?"
    user_agreement

    info "Downloading portforwarder-rs"
    wget https://github.com/pzmarzly/portforwarder-rs/releases/download/0.1.0/pf
    chmod +x pf

    info "Downloading MochiToolkit"
    git clone https://github.com/mochimo-in-a-container/mochitoolkit.git mochitoolkit --depth 1

    info "Downloading Mochimo (fork without the miner)"
    git clone https://github.com/mochimo-in-a-container/mochimo.git mochimo --depth 1

    info "Trying to install MochiToolkit..."
    mkdir mochi
    cp -r mochitoolkit/scripts mochi
    rm -rf mochitoolkit

    info "Trying to compile Mochimo (fork without the miner)..."
    cd mochimo/src
    chmod +x makeunx
    ./makeunx bin-without-cuda
    ./makeunx install
    cd ../..
    cp -r mochimo/bin mochi
    rm -rf mochimo

    info "Installation finished."
    touch initdone

    echo ""
fi

warn "Before removing ./installation, BACKUP YOUR WALLET.WAL!"
warn "IT MUTATES WHEN CREATING A NEW ADDRESS!"
warn "It is usually in ~/mochi/bin/wallet.wal - if so, you can use vagga backup and vagga restore commands."

echo ""

if [ ! -e mochi/bin ]; then
    error "Installation corrupted? Try removing ./installation directory (backup your wallet with vagga backup if necessary), or proceed at your own risk. Proceed?"
    user_agreement
fi

PF_BIN=pf
. ../scripts/$1.sh
