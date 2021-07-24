#!/bin/sh

set -e

crond

ifname=$(basename $(ls -1 /etc/wireguard/*.conf | head -1) .conf)
wg-quick up /etc/wireguard/$ifname.conf

SUBNET=$(ip -o -f inet addr show dev eth0 | awk '{print $4}')
IPADDR=$(echo "${SUBNET}" | cut -f1 -d'/')
GATEWAY=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
eval "$(ipcalc -np "${SUBNET}")"

ip -4 rule del not fwmark 51820 table 51820
ip -4 rule del table main suppress_prefixlength 0

ip -4 rule add prio 10 from "${IPADDR}" table 128
ip -4 route add table 128 to "${NETWORK}/${PREFIX}" dev eth0
ip -4 route add table 128 default via "${GATEWAY}"

ip -4 rule add prio 20 not fwmark 51820 table 51820
ip -4 rule add prio 20 table main suppress_prefixlength 0


/usr/bin/v2ray -config /etc/v2ray/config.json

