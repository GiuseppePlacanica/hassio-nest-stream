import gi
import argparse
import time

print("🔹 Avvio del server RTSP...")  # Log di debug

gi.require_version('Gst', '1.0')
gi.require_version('GstRtspServer', '1.0')
from gi.repository import Gst, GstRtspServer, GLib

# Parsing degli argomenti
parser = argparse.ArgumentParser(description="RTSP Relay Server")
parser.add_argument("--rtsp_url", required=True, help="RTSP Source URL")
parser.add_argument("--stream_port", type=int, required=True, help="Local RTSP Port")
args = parser.parse_args()

class RTSPRelayServer:
    def __init__(self, rtsp_url, port):
        print(f"🔹 Inizializzazione con URL: {rtsp_url} su porta: {port}")  # Log di debug
        self.rtsp_url = rtsp_url
        self.port = port
        Gst.init(None)
        self.server = GstRtspServer.RTSPServer()
        self.server.set_service(str(self.port))

        factory = GstRtspServer.RTSPMediaFactory()
        factory.set_launch(f"( rtspsrc location={self.rtsp_url} latency=100 ! rtph264depay ! rtph264pay name=pay0 pt=96 )")
        factory.set_shared(True)

        self.server.get_mount_points().add_factory("/live", factory)
        self.server.attach(None)

        print(f"✅ Server RTSP avviato su rtsp://0.0.0.0:{self.port}/live")

    def run(self):
        loop = GLib.MainLoop()
        loop.run()

# Avvia il server
if __name__ == "__main__":
    time.sleep(2)  # Ritardo per evitare problemi di inizializzazione
    print(f"🔹 Tentativo di avvio del server con URL: {args.rtsp_url} e porta {args.stream_port}")
    relay_server = RTSPRelayServer(args.rtsp_url, args.stream_port)
    relay_server.run()
