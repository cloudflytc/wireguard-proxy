pingtime=`ping -c 3 google.com |grep "bad address" | wc -l`
if [[ $pingtime -eq 1 ]];then
        echo "network error"
        ifname=$(basename $(ls -1 /etc/wireguard/*.conf | head -1) .conf)
        wg-quick down /etc/wireguard/$ifname.conf
        wg-quick up /etc/wireguard/$ifname.conf
else
        echo "network ok"
fi
