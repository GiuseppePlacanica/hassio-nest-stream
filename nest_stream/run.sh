#!/usr/bin/with-contenv bash
# Startup script for Nest Doorbell streaming

CONFIG_FILE="/data/options.json"

echo "✅ Starting Nest Doorbell streaming..."

# === READ CONFIGURATION FROM options.json ===
CLIENT_ID=$(jq -r '.client_id' "$CONFIG_FILE")
CLIENT_SECRET=$(jq -r '.client_secret' "$CONFIG_FILE")
REFRESH_TOKEN=$(jq -r '.refresh_token' "$CONFIG_FILE")
PROJECT_ID=$(jq -r '.project_id' "$CONFIG_FILE")
DEVICE_ID=$(jq -r '.device_id' "$CONFIG_FILE")
STREAM_PORT=$(jq -r '.stream_port' "$CONFIG_FILE")

# Function to obtain the OAuth access token
get_access_token() {
    ACCESS_TOKEN=$(curl -s -X POST "https://oauth2.googleapis.com/token" \
      -d "client_id=$CLIENT_ID" \
      -d "client_secret=$CLIENT_SECRET" \
      -d "refresh_token=$REFRESH_TOKEN" \
      -d "grant_type=refresh_token" | jq -r '.access_token')

    if [[ -z "$ACCESS_TOKEN" || "$ACCESS_TOKEN" == "null" ]]; then
        echo "❌ ERROR: Unable to obtain OAuth token!"
        exit 1
    fi
}

# Function to retrieve the Nest RTSP stream URL
get_rtsp_url() {
    RTSP_RESPONSE=$(curl -s -X POST "https://smartdevicemanagement.googleapis.com/v1/enterprises/$PROJECT_ID/devices/$DEVICE_ID:executeCommand" \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      -d '{"command": "sdm.devices.commands.CameraLiveStream.GenerateRtspStream", "params": {}}')

    RTSP_URL=$(echo "$RTSP_RESPONSE" | jq -r '.results.streamUrls.rtspUrl')
    EXPIRES_AT=$(echo "$RTSP_RESPONSE" | jq -r '.results.expiresAt')

    if [[ -z "$RTSP_URL" || "$RTSP_URL" == "null" ]]; then
        echo "❌ ERROR: No RTSP URL received from Google API!"
        exit 1
    fi

    echo "🎥 RTSP URL obtained successfully!"
}

# Start FFmpeg to convert RTSP to HTTP stream
start_ffmpeg() {
    echo "🎬 Starting FFmpeg stream..."
    exec ffmpeg -rtsp_transport tcp -i "$RTSP_URL" \
        -c:v copy -c:a aac -f mpegts -listen 1 "http://0.0.0.0:$STREAM_PORT/live.ts"
}

# Execute functions
get_access_token
get_rtsp_url
start_ffmpeg
