# Description
Docker image for transmission and flexget.

# Usage
```Docker
docker create \
  --name=transmission \
  -e TIMEZONE=<<TIMEZONE|default(UTC)>> \
  -e FG_LOG_LEVEL=<<LOGLEVEL|default(INFO)>> \
  -e FG_PASSWORD=<<PASSWORD|default(flexget)>> \
  -e TR_ALLOWED=<<ALLOWED IPS|default(127.0.0.1,192.168.0.*)>> \
  -e TR_USERNAME=<<USERNAME|default(transmission)>> \
  -e TR_PASSWORD=<<PASSWORD|default(transmission)>> \
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
