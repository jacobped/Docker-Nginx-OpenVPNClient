############################################################
# Dockerfile for container with OpenVPN-Client and Nginx
# Ideal for a local reverse proxy. With vpn as source.
############################################################

FROM debian:stable-slim
MAINTAINER Jacob Pedersen <jacob@jacobpedersen.dk>

WORKDIR /setup
ENV DEBIAN_FRONTEND noninteractive
ENV RUNLEVEL 1

COPY setup /setup/

# Get packagelist and install base packages
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d && \
	apt-get update -y && \
	apt-get install apt-utils dos2unix -y

# Fixes file formatting for all files to work properly in container. It's like magic!
RUN find . -type f -print0 | xargs -0 dos2unix

# Setup services
RUN chown -R root:root /setup && chmod -R -w+r+x /setup
RUN /setup/setup.sh

# Setup Supervisor
RUN apt-get -y install supervisor && \
	mkdir -p /etc/supervisor/conf.d && \
	cp /setup/config/supervisor.conf /etc/supervisor.conf

RUN cp /setup/config/*.sv.conf /etc/supervisor/conf.d/
RUN ls -lah /etc/supervisor/conf.d/

# Clean up APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# map /config to host defined config path, for defining nginx and openvpn configs.
VOLUME /config

# map logs
VOLUME /log

EXPOSE 80

CMD ["/bin/bash","-c","/setup/start.sh"]
