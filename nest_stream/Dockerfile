ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.0.1
FROM $BUILD_FROM

# Set environment
ENV LANG C.UTF-8

# Install necessary packages
RUN apk add --no-cache ffmpeg jq curl bash

# Create service directory for S6
RUN mkdir -p /etc/services.d/nest_stream

# Copy the startup script
COPY run.sh /etc/services.d/nest_stream/run
RUN chmod +x /etc/services.d/nest_stream/run

# Ensure the script runs as PID 1
ENTRYPOINT [ "/init" ]
