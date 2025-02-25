ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.0.1
FROM $BUILD_FROM

# Setta i parametri base dell'add-on
ENV LANG C.UTF-8

# Installa i pacchetti necessari
RUN apk add --no-cache ffmpeg jq curl

# Copia lo script di avvio
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
