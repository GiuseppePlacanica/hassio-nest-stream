ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.0.1
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Install dependencies
RUN apk add --no-cache ffmpeg jq curl bash

# Copy the script
COPY run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

# Run the script at startup
CMD [ "/usr/bin/run.sh" ]