ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.0.1
FROM $BUILD_FROM

# Set environment variables
ENV LANG C.UTF-8

# Install necessary packages
RUN apk add --no-cache ffmpeg jq curl bash

# Create S6 service directory
RUN mkdir -p /etc/services.d/nest_stream

# Copy startup script to correct S6 service directory
COPY run.sh /etc/services.d/nest_stream/run
RUN chmod +x /etc/services.d/nest_stream/run

# Ensure container starts with S6 Supervisor
CMD [ "/init" ]
