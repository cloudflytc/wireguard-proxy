#!/bin/sh

set -e

ifname=$(basename $(ls -1 /etc/wireguard/*.conf | head -1) .conf)
wg-quick up /etc/wireguard/$ifname.conf

/usr/bin/v2ray -config /etc/v2ray/config.json

