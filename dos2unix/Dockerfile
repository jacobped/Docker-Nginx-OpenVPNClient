FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive
ENV RUNLEVEL 1

RUN apt-get update && apt-get install -y dos2unix

ENTRYPOINT ["dos2unix"]
