############################################################
# Dockerfile for container with OpenVPN-Client and Nginx
# Ideal for a local reverse proxy. With vpn as source.
############################################################

FROM lsiobase/alpine:3.8

ARG BUILD_DATE
ARG VCS_REF

MAINTAINER jacobpeddk
LABEL maintainer="jacobpeddk"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-url="https://github.com/jacobped/Docker-Nginx-OpenVPNClient"
LABEL org.label-schema.vcs-ref=$VCS_REF

# install packages
RUN apk add --no-cache \
			nginx \
			openvpn

# Will shutdown upon errors in stage 2.
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# map logs
# VOLUME /log
COPY root/ /

VOLUME /config
EXPOSE 80
