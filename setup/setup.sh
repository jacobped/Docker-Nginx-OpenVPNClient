#!/bin/bash
set -e

export RUNLEVEL=1
export DEBIAN_FRONTEND='noninteractive'
#sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d
#apt-get update -y && apt-get install apt-utils -y
#apt-get update -y

#--- Setup Nginx ---
apt-get install nginx -y

useradd -r nginx
service nginx stop
update-rc.d nginx disable

# Add sample configs to config dir as usable configs.
cp /setup/config/nginx.conf.sample /config/nginx.conf
cp /setup/config/openvpn.ovpn.sample /config/openvpn.ovpn

# Reload nginx config, to use manual configured variant.
/setup/reload_nginx-config.sh

# Append "daemon off;" to the beginning of the configuration
#echo "daemon off;" >> /etc/nginx/nginx.conf

sed -i 's|invoke-rc.d nginx rotate|sv 1 nginx|' /etc/logrotate.d/nginx

#--- Setup openvpn ---
apt-get install openvpn -y
