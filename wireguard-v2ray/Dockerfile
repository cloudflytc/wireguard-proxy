# Dockerfile for v2ray based alpine
# Copyright (C) 2019 - 2020 Teddysun <i@teddysun.com>
# Reference URL:
# https://github.com/v2ray/v2ray-core
# https://github.com/v2ray/geoip
# https://github.com/v2ray/domain-list-community

FROM alpine:latest
LABEL maintainer="cloudfly23"

COPY v2ray.sh /root/v2ray.sh
COPY config.json /etc/v2ray/config.json
COPY ./entrypoint.sh /root/entrypoint.sh

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --update-cache dante-server wireguard-tools openresolv ip6tables \
  && rm -rf /var/cache/apk/*

RUN set -ex \
	&& apk add --no-cache tzdata ca-certificates \
	&& mkdir -p /var/log/v2ray \
	&& chmod +x /root/v2ray.sh \
	&& /root/v2ray.sh \
	&& rm -fv /root/v2ray.sh \
	&& wget -O /usr/bin/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat \
	&& wget -O /usr/bin/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
RUN chmod +x /root/entrypoint.sh


VOLUME /etc/v2ray
ENV TZ=Asia/Shanghai
ENTRYPOINT "/root/entrypoint.sh"

