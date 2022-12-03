#!/bin/sh
# vim: set ts=4 sw=4 ai si et:

set -e

CONF_DIR=/etc/openvpn

test -f /etc/openvpn/ta.key || /usr/sbin/openvpn --genkey --secret ${CONF_DIR}/ta.key

/usr/sbin/openvpn --status-version 2 --suppress-timestamps --dev tun --config ${CONF_DIR}/${OPENVPN_SERVER_NAME}.conf || exit $?

exit 0
