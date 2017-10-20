#!/bin/bash
set -e

export RUNLEVEL=1
export DEBIAN_FRONTEND='noninteractive'
apt-get install nginx -y

useradd -r nginx

service nginx stop

# Remove the default Nginx configuration file
rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
cp /setup/conf/nginx.conf /etc/nginx/
chown -R nginx:nginx /etc/nginx
chmod -w+r /etc/nginx/nginx.conf
chown -R nginx /var/log/nginx

# Append "daemon off;" to the beginning of the configuration
#echo "daemon off;" >> /etc/nginx/nginx.conf

sed -i 's|invoke-rc.d nginx rotate|sv 1 nginx|' /etc/logrotate.d/nginx

