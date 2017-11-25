#!/bin/bash

# Reload nginx config, to use manual configured variant.
/setup/reload_nginx-config.sh

# Start services
exec /usr/sbin/nginx -g "daemon on;" & \
exec /usr/sbin/openvpn --config /config/openvpn.ovpn
