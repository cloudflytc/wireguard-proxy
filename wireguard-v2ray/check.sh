pingtime=`curl -m 10 -o /dev/null -s -w %{http_code} https://www.netflix.com/title/70143836`
if [ "$pingtime"x = "301"x ];then
    echo "解锁netflix成功"
elif [ "$pingtime"x = "200"x ];then
    echo "解锁美国成功"
else
    while :
    do
        ifname=$(basename $(ls -1 /etc/wireguard/*.conf | head -1) .conf)
        wg-quick down /etc/wireguard/$ifname.conf
        wg-quick up /etc/wireguard/$ifname.conf


        SUBNET=$(ip -o -f inet addr show dev eth0 | awk '{print $4}')
        IPADDR=$(echo "${SUBNET}" | cut -f1 -d'/')
        GATEWAY=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
        eval "$(ipcalc -np "${SUBNET}")"

        ip -4 rule del not fwmark 51820 table 51820
        ip -4 rule del table main suppress_prefixlength 0
        ip -4 rule del prio 10 from "${IPADDR}" table 128
        ip -4 rule add prio 10 from "${IPADDR}" table 128
        ip -4 route del table 128 to "${NETWORK}/${PREFIX}" dev eth0
        ip -4 route add table 128 to "${NETWORK}/${PREFIX}" dev eth0
        ip -4 route del table 128 default via "${GATEWAY}"
        ip -4 route add table 128 default via "${GATEWAY}"

        ip -4 rule add prio 20 not fwmark 51820 table 51820
        ip -4 rule add prio 20 table main suppress_prefixlength 0
        result=`curl -m 10 -o /dev/null -s -w %{http_code} https://www.netflix.com/title/70143836`;
        ip=$(curl -4 -s --max-time 10  api64.ipify.org);
        if [ "$result"x = "301"x ];then
            break
        elif [ "$result"x = "200"x ];then
            break
        else
            echo $ip
            echo "解锁失败"
            sleep 5
        fi
    done
fi
