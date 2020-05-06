FROM alpine:latest

LABEL maintainer "Dschinghis Kahn"

####################################################
######### DEFAULT VALUES                 ###########
####################################################
ENV TIMEZONE=UTC
ENV FG_LOGLEVEL=INFO
ENV FG_PASSWORD=flexget
ENV TR_USERNAME=transmission
ENV TR_PASSWORD=transmission

####################################################
######### INSTALLING BASE STUFF          ###########
####################################################
RUN apk add --no-cache python3 && pip3 install --upgrade pip wheel

####################################################
######### INSTALLING FLEXGET             ###########
####################################################
RUN pip install --upgrade flexget

####################################################
######### INSTALLING TRANSMISSION PLUGIN ###########
####################################################
RUN pip install --upgrade transmissionrpc
####################################################
######### INSTALLING DECOMPRESS PLUGIN   ###########
####################################################
RUN apk add --no-cache unrar && pip install --upgrade rarfile

####################################################
######### INSTALLING TRANSMISSION        ###########
####################################################
RUN apk add --no-cache transmission-daemon

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
VOLUME /etc/flexget /etc/transmission /var/lib/transmission

EXPOSE 3539/TCP
EXPOSE 9091/TCP
EXPOSE 51413/TCP
EXPOSE 51413/UDP

CMD ["/init"]
