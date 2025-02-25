ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.0.1
FROM $BUILD_FROM

# Set environment
ENV LANG C.UTF-8

# Install necessary packages
RUN apk add --no-cache ffmpeg jq curl bash

# Create S6 service directory
RUN mkdir -p /etc/services.d/nest_stream

# Copy the startup script inside the service folder
COPY run.sh /etc/services.d/nest_stream/run
RUN chmod +x /etc/services.d/nest_stream/run

# Ensure the script is properly executable
RUN chmod +x /etc/services.d/nest_stream/run

# Start S6 overlay (Home Assistant requires this)
CMD [ "/init" ]
