#!/bin/bash

#if configs don't exists. Copy from samples and stop container.
if [ ! -f /config/nginx.conf ] || [ ! -f /config/openvpn.ovpn ]; then
	cp /setup/config/nginx.conf.sample /config/nginx.conf
	cp /setup/config/openvpn.ovpn.sample /config/openvpn.ovpn
	echo 'Copied sample files to directory.'
else
	if [ ! -d /log/nginx ]; then
		mkdir /log/nginx
	fi

	# Reload nginx config, to use manual configured variant.
	/setup/reload_nginx-config.sh
	nginx -t

	# Start services
	#exec /usr/sbin/nginx -g "daemon on;" & \
	#exec /usr/sbin/openvpn --config /config/openvpn.ovpn
	supervisord -n -c /etc/supervisor.conf
fi
