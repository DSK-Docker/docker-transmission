# Description
Docker image for transmission and flexget.

# Usage
```Docker
docker create \
  --name=transmission \
  -e TIMEZONE=<TIMEZONE> \
  -e FG_PASSWORD=<PASSWORD> \
  -p 3539:3539 \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -v path to flexget configs:/etc/flexget \
  -v path to transmission configs:/etc/transmission \
  -v path to transmission downloads:/var/lib/transmission \
  --restart unless-stopped \
  dschinghiskahn/transmission
```
