# OpenVPN client + SOCKS proxy
# Usage:
# Create configuration (.ovpn), mount it in a volume
# docker run --volume=something.ovpn:/ovpn.conf:ro --device=/dev/net/tun --cap-add=NET_ADMIN
# Connect to (container):1080
# Note that the config must have embedded certs
# See `start` in same repo for more ideas

FROM alpine

COPY ssserver.sh /usr/local/bin/

COPY config.json /usr/local/bin/

RUN true \
    && echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk add --update-cache openvpn bash openresolv openrc curl shadowsocks-libev \
    && rm -rf /var/cache/apk/* \
    && chmod a+x /usr/local/bin/ssserver.sh \
    && true


ENTRYPOINT [ \
    "/bin/bash", "-c", \
    "cd /etc/openvpn && /usr/sbin/openvpn --config *.conf --log /var/log/openvpn.log --script-security 2 --up /usr/local/bin/ssserver.sh" \
    ]
