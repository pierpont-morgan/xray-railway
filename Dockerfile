FROM alpine:3.21

RUN apk add --no-cache ca-certificates curl unzip \
 && mkdir -p /etc/xray \
 && VER=$(curl -fsSL https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/') \
 && curl -fsSL -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/v${VER}/Xray-linux-64.zip" \
 && unzip -q /tmp/xray.zip -d /usr/local/bin xray \
 && rm -f /tmp/xray.zip \
 && chmod +x /usr/local/bin/xray \
 && xray version

COPY config.template.json /etc/xray/config.template.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
