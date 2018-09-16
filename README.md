# Mochimo client in a container

Automatically:

- downloads Ubuntu 16.04 cloudimg and `build-essential`
- downloads and compiles Mochimo client
- downloads [MochiToolkit](https://github.com/chrisdigity/mochitoolkit)
- downloads and runs [portforwarder-rs](https://github.com/pzmarzly/portforwarder-rs) for automatic port redirection when possible
- generates new `wallet.dat`
- runs `wallet` with hardcoded peer address for faster connection

![Screenshot of running script](screenshot1.png)

## Installation

Install [Vagga](https://vagga.readthedocs.io/en/latest/installation.html), then download this repo and run commands.

500MB of space is required for normal installation, 1.5GB if you also build portforwarder-rs from scratch (after installation and cleanup container takes 1GB).

## Commands

- `vagga shell` - run `bash` in the container
- `vagga wallet` - run Mochimo `wallet` binary
- `vagga wallet-pf` - try to forward ports and run `wallet`. AMD64 only
- `vagga wallet-pf-native` - build portforwarder-rs from scratch, then run `wallet-pf`
- `vagga backup` - copy `wallet.wal` from `installation` to main directory (where README is)
- `vagga restore` - copy `wallet.wal` from main directory (where README is) to `installation`