ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.0.1
FROM $BUILD_FROM

# Environment variables
ENV LANG C.UTF-8

# Install necessary packages
RUN apk add --no-cache \
    ffmpeg \
    jq \
    curl \
    bash

# Create S6 service directory
RUN mkdir -p /etc/services.d/nest_stream

# Copy the startup script to the service directory
COPY run.sh /etc/services.d/nest_stream/run
RUN chmod +x /etc/services.d/nest_stream/run

# Set correct entrypoint to S6 supervisor
ENTRYPOINT [ "/init" ]

# Add health check to verify FFmpeg is running
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD pgrep -x ffmpeg || exit 1

# Labels for Home Assistant integration
LABEL \
    io.hass.name="Nest Stream" \
    io.hass.description="Nest Doorbell Streaming for Home Assistant" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="1.0.0" \
    maintainer="Giuseppe Placanica <@yourgithub>" \
    org.opencontainers.image.title="Nest Stream" \
    org.opencontainers.image.description="Stream Nest Doorbell RTSP to Home Assistant" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/GiuseppePlacanica/hassio-nest-stream" \
    org.opencontainers.image.documentation="https://github.com/GiuseppePlacanica/hassio-nest-stream/blob/main/README.md"
