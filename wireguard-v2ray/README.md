docker run -it --rm --cap-add=NET_ADMIN \
     --privileged \
    --name wireguard-v2ray \
    --volume /etc/wireguard/:/etc/wireguard/:ro \
    --volume /etc/v2ray:/etc/v2ray \
    -p 映射端口:配置文件内设置的端口 \
    cloudfly23/wireguard-proxy-v2ray
