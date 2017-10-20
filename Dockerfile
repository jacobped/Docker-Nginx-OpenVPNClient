############################################################
# Dockerfile for container with OpenVPN-Client and Nginx
# Ideal for a local reverse proxy. With vpn as source.
############################################################

FROM debian:stable-slim
MAINTAINER Jacob Pedersen <jacob@jacobpedersen.dk>

ENV HOME /root

ADD . /setup
RUN /setup/setup.sh

# Clean up APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

CMD ["/setup/start.sh"]
