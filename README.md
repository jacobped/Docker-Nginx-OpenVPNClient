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

## Usage

```
docker create \
  --cap-add=NET_ADMIN \
  --name=nginxopenvpn \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 8282:80 \
  -e TZ=<timezone> \
  linuxserver/letsencrypt
```
### Port mapping
Port mapping is optional and only needed for testing the nginx reverse proxy config locally.  
To test it locally, visit: `<host ip>:8282`

### PGID and PUID
Will define the user and group ids that the container will handle the files and processes as.  

PGID can be found by executing: `id -g`  
PUID can be found by executing: `id -u`  

## Build & Run
Download repository,and run the following command on you host to build the image. 

```
docker build -t nginx-openvpnclient .
```

To test it:

```
docker run -it --rm --name nginxopenvpn -e PGID=<gid> -e PUID=<uid> -p 8282:80 --cap-add=NET_ADMIN --device=/dev/net/tun -v <localConfigPath>:/config nginx-openvpnclient
```

And if everything is set up correctly, it should now connect and proxy traffix comming from the vpn connection.

# Usefull websites resources
 * [linuxserver.io alpine base image](https://github.com/linuxserver/docker-baseimage-alpine/)
 * [S6 service handler for containers](https://github.com/just-containers/s6-overlay)
 * [Information about the s6-svscanctl program](https://skarnet.org/software/s6/s6-svscanctl.html)


# Changelog
Important changes will be listed here.  
Pattern is: year-month-date

## 2018-08-19  
Major changes to image. Made it far more robust and smaller in size.
* Removed dos2unix - It will no longer fix files created with wrong line ending on windows.
* Changes image base to the alpine image with s6 support from [linuxserver.io](https://github.com/linuxserver/docker-baseimage-alpine/)
* Changed everything to use the [s6 service handler](https://github.com/just-containers/s6-overlay). 
* log dir is now part of config dir.
* Total image size decreased from 70MB to 9MB.
