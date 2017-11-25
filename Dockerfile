############################################################
# Dockerfile for container with OpenVPN-Client and Nginx
# Ideal for a local reverse proxy. With vpn as source.
############################################################

FROM debian:stable-slim
MAINTAINER Jacob Pedersen <jacob@jacobpedersen.dk>

ENV HOME /root

COPY setup/* /setup/
RUN chown -R root:root /setup && \
	chmod -R -w+r+x /setup && \
	ls -lah /setup && \
	/setup/update-apt.sh && \
	/setup/setup.sh

# Clean up APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# map /config to host defined config path, for defining nginx and openvpn configs.
VOLUME /config

EXPOSE 80

CMD ["/setup/start.sh"]
