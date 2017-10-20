#!/bin/bash

exec /usr/sbin/nginx -g "daemon on;" & \
exec /usr/sbin/openvpn --config /setup/conf/openvpn.ovpn

