#!/bin/sh
set -e

export DEBIAN_FRONTEND='noninteractive'
sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d
apt-get update -y && apt-get install apt-utils -y
#apt-get update -y

# Setup Nginx
/setup/nginx-setup.sh
/setup/openvpn-setup.sh

