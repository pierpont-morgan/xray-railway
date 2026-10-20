#!/bin/sh
# Renders /etc/xray/config.json from the template using Railway Variables.
# Required env: UUID, WS_PATH. PORT is injected by Railway.
set -e
: "${UUID:?UUID env is required}"
: "${WS_PATH:?WS_PATH env is required}"
PORT="${PORT:-8080}"
sed -e "s#__PORT__#${PORT}#g" \
    -e "s#__UUID__#${UUID}#g" \
    -e "s#__WS_PATH__#${WS_PATH}#g" \
    /etc/xray/config.template.json > /etc/xray/config.json
exec /usr/local/bin/xray run -c /etc/xray/config.json
