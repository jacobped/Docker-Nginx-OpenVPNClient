#!/bin/bash
set -e

export RUNLEVEL=1
export DEBIAN_FRONTEND='noninteractive'

# Remove the default Nginx configuration file
rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
cp /config/nginx.conf /etc/nginx/
chown -R nginx:nginx /etc/nginx
chmod -w+r /etc/nginx/nginx.conf
chown -R nginx /var/log/nginx
