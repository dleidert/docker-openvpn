# OpenVPN server

ARG VERSION

FROM debian:bullseye-slim

LABEL version="${VERSION}"
LABEL maintainer="Daniel Leidert <daniel.leidert@wgdd.de>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y openvpn iptables locales-all && \
    update-alternatives --set iptables /usr/sbin/iptables-legacy && \
    update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

RUN mkdir -p /dev/net && \
    test ! -c /dev/net/tun && \
    mknod /dev/net/tun c 10 200

ADD ./etc/sysctl.d/* /etc/sysctl.d/

ENV OPENVPN_SERVER_NAME=server

WORKDIR /etc/openvpn

VOLUME ["/etc/openvpn"]
VOLUME ["/var/log/openvpn"]

EXPOSE 1194/udp

CMD ["/bin/sh", "-c", "/usr/sbin/openvpn --status-version  2 --suppress-timestamps --config ${OPENVPN_SERVER_NAME}.conf"]
