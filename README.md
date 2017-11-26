# Docker-Nginx-OpenVPNClient
Docker powered container for using Nginx in combination with an OpenVPN Client. 

Ideal for a local reverse-proxy with incoming requests coming through an OpenVPN connection.

## Example scenario:
You have a docker host with containers on your local network, which you would like to be accessible to the outside world, but you can't open firewall ports. Or you simple prefer having the external ip for the services originate somewhere else.
Get a VPS and set it up with an OpenVPN Host and Nginx to reverse-proxy traffic from it. 
Then setup this container with a custom nginx config, and an OpenVPN client connecting config that can connect to the OpenVPN Host. 

This way, you can set it up so when someone visits your vps on the given port that you forward traffic from to the vpn client, the request will be proxied through the vpn connection to the container. And from there the installed Nginx instance will proxy that request to some other container(s) or service(s) you have defined. 

*Web Browser* -> *VPS* --VPN-Tunnel--> *This Container* -> *Service*

It's a bit complex, but absolutely amazing when you have it running. 

I'll make it a bit easier to update the configs later, by having them loaded in every time the container starts from a mounted volume.

## Run
Command to run the container in the background

`docker run -d --name nginxopenvpn -p 80:80 --cap-add=NET_ADMIN --device=/dev/net/tun -v localConfigPath:/config -v localLogPath:/log jacobpeddk/nginx-openvpnclient`

Remember to at least map local path to container's /config.
If no configs exists in local mapped folder, it will add samle configs and terminate.
Then you update sample configs and run the container again.

`docker start nginxopenvpn`

## Build & Run
Download repository, edit the configs, and run the following command on you host to build the image. 

**(Remember to edit configs before you build)**

`docker build -t nginx-openvpnclient .`

Command to run the container in the background

`docker run -d --name nginxopenvpn -p 80:80 --cap-add=NET_ADMIN --device=/dev/net/tun -v localConfigPath:/config -v localLogPath:/log nginx-openvpnclient`

And if everything is set up correctly, it should now connect and proxy traffix comming from the vpn connection.
