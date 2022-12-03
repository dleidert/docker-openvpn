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
    update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy && \
    mkdir -p /app

ADD --chmod=755 *.sh /app/

ENV OPENVPN_SERVER_NAME=server

VOLUME ["/etc/openvpn"]
VOLUME ["/var/log/openvpn"]

EXPOSE 1194/udp

WORKDIR /app

ENTRYPOINT ["/app/entrypoint.sh"]
