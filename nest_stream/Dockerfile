ARG BUILD_FROM=ghcr.io/hassio-addons/base:latest
FROM $BUILD_FROM

# Installa ffmpeg e jq
RUN apk add --no-cache ffmpeg jq curl

# Copia i file dello script
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]

