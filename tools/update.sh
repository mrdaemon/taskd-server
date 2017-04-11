#!/usr/bin/env bash

# gnutls sucks a lot

#HOSTROOT="/srv/taskd"
#LE_ROOT="/etc/letsencrypt/live/tasks.underwares.org"

#mkdir -p $HOSTROOT/ssl
#cp "$LE_ROOT/privkey.pem" "$HOSTROOT/ssl/server.key.pem"
#cp "$LE_ROOT/fullchain.pem" "$HOSTROOT/ssl/server.cert.pem"

#chown -R nobody:nogroup "$HOSTROOT/ssl"
#chmod 500 "$HOSTROOT/ssl"
#chmod 400 "$HOSTROOT"/ssl/{server.key,server.cert,ca.cert}.pem

docker pull mrdaemon/taskd:production
docker-compose up -d
