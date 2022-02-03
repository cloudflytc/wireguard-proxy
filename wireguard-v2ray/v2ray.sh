#!/bin/sh
#
# This is a Shell script for v2ray based alpine with Docker image
# 
# Copyright (C) 2019 - 2020 Teddysun <i@teddysun.com>
#
# Reference URL:
# https://github.com/v2fly/v2ray-core.git

sys_bit=$(uname -m)

case $sys_bit in
i[36]86)
        ARCH="386"
        caddy_arch="386"
        ;;
'amd64' | x86_64)
        ARCH="amd64"
        caddy_arch="amd64"
        ;;
*armv6*)
        ARCH="arm6"
        caddy_arch="arm6"
        ;;
*armv7*)
        ARCH="arm7"
        caddy_arch="arm7"
        ;;
*aarch64* | *armv8*)
        ARCH="arm64"
        caddy_arch="arm64"
        ;;
*)
        echo -e " 
        哈哈……这个 ${red}辣鸡脚本${none} 不支持你的系统。 ${yellow}(-_-) ${none}

        备注: 仅支持 Ubuntu 16+ / Debian 8+ / CentOS 7+ 系统
        " && exit 1
        ;;
esac
# Download binary file
V2RAY_FILE="v2ray_linux_${ARCH}"

echo "Downloading binary file: ${V2RAY_FILE}"
wget -O /usr/bin/v2ray https://dl.lamp.sh/files/${V2RAY_FILE} > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Failed to download binary file: ${V2RAY_FILE}" && exit 1
fi
echo "Download binary file: ${V2RAY_FILE} completed"

chmod +x /usr/bin/v2ray

