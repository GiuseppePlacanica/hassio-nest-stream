#!/bin/bash

CONFIG_PATH=/data/options.json

CLIENT_ID=$(jq --raw-output '.client_id' $CONFIG_PATH)
CLIENT_SECRET=$(jq --raw-output '.client_secret' $CONFIG_PATH)
REFRESH_TOKEN=$(jq --raw-output '.refresh_token' $CONFIG_PATH)
PROJECT_ID=$(jq --raw-output '.project_id' $CONFIG_PATH)
DEVICE_ID=$(jq --raw-output '.device_id' $CONFIG_PATH)
STREAM_PORT=$(jq --raw-output '.stream_port' $CONFIG_PATH)

# Funzione per ottenere un nuovo URL RTSP
generate_rtsp_url() {
    echo "🔄 Generating new RTSP URL..."
    ACCESS_TOKEN=$(curl -s -X POST "https://oauth2.googleapis.com/token" \
      -d "client_id=$CLIENT_ID" \
      -d "client_secret=$CLIENT_SECRET" \
      -d "refresh_token=$REFRESH_TOKEN" \
      -d "grant_type=refresh_token" | jq -r '.access_token')

    RTSP_RESPONSE=$(curl -s -X POST "https://smartdevicemanagement.googleapis.com/v1/enterprises/$PROJECT_ID/devices/$DEVICE_ID:executeCommand" \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      -d '{ "command": "sdm.devices.commands.CameraLiveStream.GenerateRtspStream", "params": {} }')

    RTSP_URL=$(echo "$RTSP_RESPONSE" | jq -r '.results.streamUrls.rtspUrl')
    EXPIRES_AT=$(echo "$RTSP_RESPONSE" | jq -r '.results.expiresAt')

    echo "✅ New RTSP URL: $RTSP_URL (Expires at: $EXPIRES_AT)"
}

# Avvia il server RTSP con il primo URL
generate_rtsp_url
python3 /app/relay_rtsp.py --rtsp_url "$RTSP_URL" --stream_port "$STREAM_PORT" &

# Monitor e rinnovo dell'URL prima della scadenza
while true; do
    sleep 270  # Controlla ogni 30 minuti
    echo "⚠️ Generating a new URL..."
    generate_rtsp_url
    pkill -f relay_rtsp.py
    python3 /app/relay_rtsp.py --rtsp_url "$RTSP_URL" --stream_port "$STREAM_PORT" &
done
