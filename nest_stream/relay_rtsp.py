import requests
import gi
import time
import argparse
from gi.repository import Gst, GstRtspServer, GLib

# Initialize GStreamer
gi.require_version('Gst', '1.0')
gi.require_version('GstRtspServer', '1.0')
Gst.init(None)

# Parse arguments
parser = argparse.ArgumentParser(description="RTSP Relay Server")
parser.add_argument("--rtsp_url", required=True, help="RTSP Source URL")
parser.add_argument("--stream_port", type=int, required=True, help="Local RTSP Port")
args = parser.parse_args()

# RTSP Server
class RTSPRelayServer:
    def __init__(self, rtsp_url, port):
        self.rtsp_url = rtsp_url
        self.port = port
        self.server = GstRtspServer.RTSPServer()
        self.server.set_service(str(self.port))

        factory = GstRtspServer.RTSPMediaFactory()
        factory.set_launch(f"( rtspsrc location={self.rtsp_url} latency=100 ! rtph264depay ! rtph264pay name=pay0 pt=96 )")
        factory.set_shared(True)

        self.server.get_mount_points().add_factory("/live", factory)
        self.server.attach(None)

        print(f"✅ RTSP Server started at rtsp://0.0.0.0:{self.port}/live")

    def run(self):
        loop = GLib.MainLoop()
        loop.run()

# Start RTSP Server
relay_server = RTSPRelayServer(args.rtsp_url, args.stream_port)
relay_server.run()
