#!/bin/bash

set -e

echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.conf

ss-server -c "/usr/local/bin/config.json" > /dev/null &
