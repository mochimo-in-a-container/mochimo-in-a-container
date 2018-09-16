#!/bin/bash
set -e

error () {
    echo -e -n '\033[1;31m'
    echo $1
    echo -e -n '\033[0m'
}

info () {
    echo -e -n '\033[1;32m'
    echo $1
    echo -e -n '\033[0m'
}

warn () {
    echo -e -n '\033[1;33m'
    echo $1
    echo -e -n '\033[0m'
}

user_agreement () {
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) break;;
            No ) error "Cannot proceed"; exit 1;;
        esac
    done
}