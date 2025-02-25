ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.0.1
FROM $BUILD_FROM

# Imposta la configurazione di ambiente
ENV LANG C.UTF-8

# Installa i pacchetti necessari
RUN apk add --no-cache ffmpeg jq curl bash

# Copia lo script di avvio
COPY run.sh /etc/services.d/nest_stream/run
RUN chmod +x /etc/services.d/nest_stream/run

# Avvia il supervisore S6 (richiesto per Hassio)
CMD [ "/init" ]
