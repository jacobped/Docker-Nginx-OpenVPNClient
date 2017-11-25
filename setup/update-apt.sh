#!/bin/sh

export RUNLEVEL=1
export DEBIAN_FRONTEND='noninteractive'
sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d
apt-get update -y && apt-get install apt-utils -y
