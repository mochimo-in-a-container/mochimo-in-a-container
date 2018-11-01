#!/bin/bash
mkdir -p installation
export HOME=/work/installation
cd

. ../scripts/_utils.sh

# first setup
if [ ! -e initdone ]
then
    warn "No installation of Mochimo client found, starting the installer..."
    echo "Link to Mochimo license: https://raw.githubusercontent.com/mochimodev/mochimo/master/LICENSE.TXT"
    echo "Do you agree to Mochimo license?"
    user_agreement

    echo "Link to MochiToolkit license: https://raw.githubusercontent.com/chrisdigity/mochitoolkit/master/LICENSE"
    echo "Do you agree to MochiToolkit license?"
    user_agreement

    echo "Link to portforwarder-rs license: https://raw.githubusercontent.com/pzmarzly/portforwarder-rs/master/LICENSE"
    echo "Do you agree to portforwarder-rs license?"
    user_agreement

    info "Downloading portforwarder-rs"
    wget https://github.com/pzmarzly/portforwarder-rs/releases/download/0.1.0/pf
    chmod +x pf

    info "Downloading MochiToolkit"
    git clone https://github.com/chrisdigity/mochitoolkit.git mochitoolkit --depth 1

    info "Trying to install MochiToolkit..."
    mkdir mochi
    cp -r mochitoolkit/scripts mochi

    info "Running MochiToolkit minst..."
    ./mochi/scripts/minst

    info "Cleaning up..."
    rm -rf mochitoolkit

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