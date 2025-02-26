ARG BUILD_FROM=ghcr.io/hassio-addons/base:12.0.0
FROM $BUILD_FROM

# Set environment variables
ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED 1

# Install only essential dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    gstreamer \
    gst-plugins-base \
    gst-plugins-good \
    gst-rtsp-server \
    jq

# Install Python dependencies
RUN pip install requests

# Copy add-on files
COPY relay_rtsp.py /app/relay_rtsp.py
COPY run.sh /usr/bin/run.sh

# Set permissions and entrypoint
RUN chmod +x /usr/bin/run.sh
WORKDIR /app

CMD ["/usr/bin/run.sh"]
