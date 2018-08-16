# Docker-Nginx-OpenVPNClient
Docker powered container for using Nginx in combination with an OpenVPN Client. 

Ideal for a local reverse-proxy with incoming requests coming through an OpenVPN connection.

### Docker Image
[![Docker Pulls](https://img.shields.io/docker/pulls/jacobpeddk/nginx-openvpnclient.svg)](https://hub.docker.com/r/jacobpeddk/nginx-openvpnclient)
[![Docker Stars](https://img.shields.io/docker/stars/jacobpeddk/nginx-openvpnclient.svg)](https://hub.docker.com/r/jacobpeddk/nginx-openvpnclient)
[![](https://images.microbadger.com/badges/image/jacobpeddk/nginx-openvpnclient.svg)](https://microbadger.com/images/jacobpeddk/nginx-openvpnclient "Container Image size and layers")
[![](https://images.microbadger.com/badges/commit/jacobpeddk/nginx-openvpnclient.svg)](https://microbadger.com/images/jacobpeddk/nginx-openvpnclient "Current commit that the container is build from")
[![](https://images.microbadger.com/badges/version/jacobpeddk/nginx-openvpnclient.svg)](https://microbadger.com/images/jacobpeddk/nginx-openvpnclient "Container version")

### Example scenario:
You have a docker host with containers on your local network, which you would like to be accessible to the outside world, but you can't open firewall ports. Or you simple prefer having the external ip for the services originate somewhere else.
Get a VPS and set it up with an OpenVPN Host and Nginx to reverse-proxy traffic from it. 
Then setup this container with a custom nginx config, and an OpenVPN client connecting config that can connect to the OpenVPN Host. 

This way, you can set it up so when someone visits your vps on the given port that you forward traffic from to the vpn client, the request will be proxied through the vpn connection to the container. And from there the installed Nginx instance will proxy that request to some other container(s) or service(s) you have defined. 

*Web Browser* -> *VPS* --VPN-Tunnel--> *This Container* -> *Service*

It's a bit complex, but absolutely amazing when you have it running. You can also proxy in the opposite direction, if you configure the Nginx config that way.

### Note
The container comes with sample configs, that'll be added to the mapped /config volume if they don't already exist.
Just overwrite those with your changes.

## Run
Command to run the container in the background

`docker run -d --name nginxopenvpn -p 80:80 --cap-add=NET_ADMIN --device=/dev/net/tun -v localConfigPath:/config -v localLogPath:/log jacobpeddk/nginx-openvpnclient`

Remember to at least map host path to container's /config.
If no configs exists in host mapped folder, it will add samle configs to it and terminate.
Then you can update sample configs and run the container again.

`docker start nginxopenvpn`

## Build & Run
Download repository,and run the following command on you host to build the image. 

`docker build -t nginx-openvpnclient .`

Command to run the container in the background. (replace `localConfigPath` and `localLogPath` with their respective host paths.

`docker run -d --name nginxopenvpn -p 80:80 --cap-add=NET_ADMIN --device=/dev/net/tun -v localConfigPath:/config -v localLogPath:/log nginx-openvpnclient`

And if everything is set up correctly, it should now connect and proxy traffix comming from the vpn connection.
