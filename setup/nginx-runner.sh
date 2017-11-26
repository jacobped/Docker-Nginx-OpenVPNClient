#!/bin/bash
service=nginx

/usr/sbin/nginx -t && /etc/init.d/nginx start &

while true; do
	if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
		then
			echo "$service is running!!!"
		else
			#/etc/init.d/$service start
			echo "$service is down"
			break
	fi
	sleep 15
done
