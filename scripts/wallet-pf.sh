#!/bin/bash
info "Redirecting ports and waiting for 5 seconds..."
./$PF_BIN any TCP/2095/2095 UDP/2095/2095 &
PF_PID=$!

# TODO: sleep in a better way
sleep 5

info "Starting wallet..."
# https://unix.stackexchange.com/q/80975/231541
# `|| true` for clean up after ctrl-c
bash -m -c ". ../scripts/_utils.sh && . ../scripts/wallet.sh" || true

info "Closing opened ports..."
kill -s SIGINT $PF_PID
wait $PF_PID