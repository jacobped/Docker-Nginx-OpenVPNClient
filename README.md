# Docker-Nginx-OpenVPNClient
Docker powered container for using Nginx in combination with an OpenVPN Client. 
Ideal for a local reverse-proxy with incomming requests comming trhu an OpenVPN connection.

## Example scenario:
You have a docker host with containers on you local network, which you would like to be accessible to the outside world, but you can't open firewall ports. Or you simple prefer having the external ip for the services originate somewhere else.
Get a VPS and set it up with an OpenVpn Host and Nginx to reverse-proxy traffic from it. 
Then setup this container with a custom nginx config, and an openvpn client connectin config that can connct to the OpenVPN Host. 

This way, you can set it up so when someone visits your vps on the given port that you froward traffic from to the vpn client, the request will be proxied thru the vpn connection to the container. And from there the installed Nginx instance will proxy that request to whatvever other container or service you have defined. 
*Web Browser* -> *VPS* --VPN-Tunnel--> *This Container* -> *Service*

It's a bit complex, but absolutely amaing when you have it running. 

I'll make it a bit easier to update the configs later, by having them loaded in every time the container starts from a mounted volume.
