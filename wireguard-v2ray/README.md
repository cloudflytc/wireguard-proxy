### 本项目可以通过 docker 容器将 wireguard  转换为 v2ray 
  
  
## 项目特点：
1.自带监控脚本，检查docker内网络状况，判断wireguard链接状态，出问题快速重连  
2.全局使用wireguard，无需动机器的路由，有效防止机器因为wireguard配置问题失联  
3.内置了 jq speedtest-cli 可以直接运行流媒体检测脚本和测速


  
  
## 注意事项：  
1. docker默认没开启ipv6，请将wireguard配置中关于v6的部分删除




## docker 部署脚本:
```
docker run -d --restart=always --cap-add=NET_ADMIN \
     --privileged \
    --name wireguard-v2ray \
    --volume /etc/wireguard/:/etc/wireguard/:ro \
    --volume /etc/v2ray:/etc/v2ray \
    -p 映射端口:配置文件内设置的端口 \
    cloudfly23/wireguard-proxy-v2ray
```
