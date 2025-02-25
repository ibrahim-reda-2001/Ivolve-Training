#!/bin/bash
####
# Ping sweep for 172.16.17.x subnet
for x in {0..255}; do
    ip="172.18.208.$x"
    if ping -c 1 -W 1 "$ip" &> /dev/null; then
        echo "Server $ip is up and running"
    else
        echo "Server $ip is unreachable"
    fi
done