FROM debian:stable-slim

LABEL maintainer "Dschinghis Kahn"

####################################################
######### DEFAULT VALUES                 ###########
####################################################
ENV TIMEZONE=UTC
ENV FG_LOG_LEVEL=info
ENV FG_PASSWORD=flexget
ENV TR_ALLOWED=127.0.0.1,192.168.0.*
ENV TR_USERNAME=transmission
ENV TR_PASSWORD=transmission

####################################################
######### INSTALLING BASE STUFF          ###########
####################################################
RUN \
  apt-get update && \
  apt-get install -y \
    python3 \
    python3-pip \
    procps \
    netcat

####################################################
######### INSTALLING FLEXGET             ###########
####################################################
RUN \
  pip install --upgrade --ignore-installed flexget

####################################################
######### INSTALLING TRANSMISSION PLUGIN ###########
####################################################
RUN \
  pip install --upgrade transmission-rpc

####################################################
######### INSTALLING DECOMPRESS PLUGIN   ###########
####################################################
RUN \
  apt-get install -y unar && \
  pip install --upgrade rarfile

####################################################
######### INSTALLING TRANSMISSION        ###########
####################################################
RUN \
  apt-get install -y transmission-daemon

####################################################
######### SETUP FILES & FOLDERS          ###########
####################################################
COPY init /

####################################################
######### CLEANUP                        ###########
####################################################
RUN rm -rf /tmp/* /root/.cache

####################################################
######### DEFINING VOLUMES               ###########
####################################################
VOLUME \
  /etc/flexget \
  /etc/transmission \
  /var/lib/transmission

EXPOSE 3539/TCP
EXPOSE 9091/TCP
EXPOSE 51413/TCP
EXPOSE 51413/UDP

HEALTHCHECK CMD nc -z localhost 9091 || exit 1

CMD ["/init"]
