pingtime=`curl -I -m 10 -o /dev/null -s -w %{http_code} http://www.gstatic.com/generate_204`
if [[ "$pingtime"x != "204"x ]];then
        echo "network error"
        ifname=$(basename $(ls -1 /etc/wireguard/*.conf | head -1) .conf)
        wg-quick down /etc/wireguard/$ifname.conf
        wg-quick up /etc/wireguard/$ifname.conf
else
        echo "network ok"
fi
