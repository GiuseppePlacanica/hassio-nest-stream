ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base:latest
FROM $BUILD_FROM

# Set environment variables
ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED 1

# Enable Alpine Edge Repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk update

# Install all required dependencies (Fix: No broken formatting!)
RUN apk add --no-cache \
    git \
    build-base \
    python3 \
    py3-pip \
    py3-requests \
    gstreamer \
    gst-plugins-base \
    gst-plugins-good \
    gst-plugins-bad \
    gst-plugins-ugly \
    gst-rtsp-server \
    gstreamer-dev \
    glib-dev \
    gobject-introspection-dev \
    libffi-dev \
    gettext-dev \
    zlib-dev \
    flex \
    bison \
    jq

# Copy add-on files
COPY relay_rtsp.py /app/relay_rtsp.py
COPY run.sh /usr/bin/run.sh

# Set permissions and entrypoint
RUN chmod +x /usr/bin/run.sh
WORKDIR /app

CMD ["/usr/bin/run.sh"]
