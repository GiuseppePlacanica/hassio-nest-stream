ARG BUILD_FROM=ghcr.io/hassio-addons/base:12.0.0
FROM $BUILD_FROM

# Set environment variables
ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED 1

# Install dependencies
RUN apk add --no-cache \
    git \
    build-base \  # <--- Aggiunto per fornire GCC e strumenti di compilazione
    python3 \
    py3-pip \
    gstreamer \
    gst-plugins-base \
    gst-plugins-good \
    gstreamer-dev \
    meson \
    ninja \
    jq

# Compile and install gst-rtsp-server
RUN git clone https://gitlab.freedesktop.org/gstreamer/gst-rtsp-server.git /tmp/gst-rtsp-server && \
    cd /tmp/gst-rtsp-server && \
    meson build && \
    ninja -C build && \
    ninja -C build install && \
    rm -rf /tmp/gst-rtsp-server

# Install Python dependencies
RUN pip install requests

# Copy add-on files
COPY relay_rtsp.py /app/relay_rtsp.py
COPY run.sh /usr/bin/run.sh

# Set permissions and entrypoint
RUN chmod +x /usr/bin/run.sh
WORKDIR /app

CMD ["/usr/bin/run.sh"]
