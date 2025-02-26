# Nest Stream Add-on for Home Assistant

## Overview
This add-on allows you to stream the **RTSPS feed from your Google Nest Doorbell** to **Home Assistant** using GStreamer and Python. The RTSP feed is retrieved via the Google Smart Device Management (SDM) API and is relayed as a stable RTSP stream, fully compatible with **MotionEye**.

## Features
- ✅ **Dynamically retrieves the RTSP feed** from the Google API
- ✅ **Relays the RTSP feed via GStreamer** for increased stability
- ✅ **Automatically renews the RTSP URL** before expiration
- ✅ **Compatible with Home Assistant OS (Hassio) and MotionEye**
- ✅ **Supports ARM64 (Raspberry Pi 4), AMD64, and other architectures**
- ✅ **Full RTSP relay compatibility with MotionEye and VLC**

## Installation

### 1️⃣ Install the Add-on
1. **Go to Home Assistant** → **Settings** → **Add-ons**.
2. Click **"Add-on Store"**.
3. Click **"Repositories"** at the bottom right.
4. Enter the repository URL: `https://github.com/GiuseppePlacanica/hassio-nest-stream`
5. Click **"Add"**, then find and install **Nest Stream**.

### 2️⃣ Configure the Add-on
Modify the configuration options in **Home Assistant** under **Settings** → **Add-ons** → **Nest Stream**:

```json
{
  "client_id": "YOUR_CLIENT_ID",
  "client_secret": "YOUR_CLIENT_SECRET",
  "refresh_token": "YOUR_REFRESH_TOKEN",
  "project_id": "YOUR_PROJECT_ID",
  "device_id": "YOUR_DEVICE_ID",
  "stream_port": 8554
}
```

### 3️⃣ Start the Add-on
- Click **Start**.
- Check the logs to verify that the streaming is running.

### 4️⃣ Add the Camera to Home Assistant and MotionEye
Go to **Settings** → **Integrations** → **Generic RTSP Camera** and use:
```
rtsp://<YOUR_HOME_ASSISTANT_IP>:<STREAM_PORT>/live
```
If you use **MotionEye**, you can add the camera by entering the same URL in the new camera configuration.

## Obtaining the Required Parameters
To configure the add-on, you need to obtain several API credentials from Google:

### 1️⃣ Enable the Google Smart Device Management API
1. Go to the **[Google Cloud Console](https://console.cloud.google.com/)**.
2. Create a **new project** or select an existing one.
3. Navigate to **APIs & Services** → **Library**.
4. Search for **Smart Device Management API** and enable it.

### 2️⃣ Create OAuth Credentials
1. Go to **APIs & Services** → **Credentials**.
2. Click **Create Credentials** → **OAuth 2.0 Client ID**.
3. Select **Web Application** and set a name.
4. Under **Authorized Redirect URIs**, add:
   ```
   https://developers.google.com/oauthplayground
   ```
5. Click **Create** and note down your **Client ID** and **Client Secret**.

### 3️⃣ Obtain a Refresh Token
1. Go to **[OAuth 2.0 Playground](https://developers.google.com/oauthplayground)**.
2. Click the settings gear ⚙️ and enable **Use your own OAuth credentials**.
3. Enter your **Client ID** and **Client Secret**.
4. Under **Step 1: Select & Authorize APIs**, enter:
   ```
   https://www.googleapis.com/auth/sdm.service
   ```
5. Click **Authorize APIs** and allow permissions.
6. In **Step 2: Exchange authorization code for tokens**, click **Exchange Authorization Code for Tokens**.
7. Copy the **Refresh Token** displayed.

### 4️⃣ Get the Project ID and Device ID
1. Open a terminal and run:
   ```bash
   curl -s -X GET "https://smartdevicemanagement.googleapis.com/v1/enterprises" \
     -H "Authorization: Bearer <YOUR_ACCESS_TOKEN>" \
     -H "Content-Type: application/json"
   ```
2. Note down the **project_id** from the response.
3. Get the list of devices:
   ```bash
   curl -s -X GET "https://smartdevicemanagement.googleapis.com/v1/enterprises/<PROJECT_ID>/devices" \
     -H "Authorization: Bearer <YOUR_ACCESS_TOKEN>" \
     -H "Content-Type: application/json"
   ```
4. Find the **device_id** of your Nest camera.

## Configuration Details

### Environment Variables Used
| Variable        | Description |
|-----------------|-------------|
| `client_id`    | Google API Client ID |
| `client_secret` | Google API Client Secret |
| `refresh_token` | OAuth Refresh Token |
| `project_id`   | Google Smart Device Management Project ID |
| `device_id`    | Nest Camera Device ID |
| `stream_port`  | Port where the RTSP relay runs (default: 8554) |

## Troubleshooting

### ❌ The RTSP Stream Does Not Appear in HA or MotionEye
- Check the logs in the log tab

### ❌ API Issues
- Ensure your **Google OAuth credentials** are correct.
- Verify that **your Nest device supports RTSP streaming** in the Google Home or Nest app.

## Contributions
Feel free to **fork** the repository and submit **pull requests**! 🚀



---

# Nest Stream Add-on per Home Assistant

## Panoramica
Questo add-on consente di trasmettere il **feed RTSPS del tuo Google Nest Doorbell** a **Home Assistant** utilizzando GStreamer e Python. Il flusso RTSP viene recuperato tramite l'API Google Smart Device Management (SDM) e viene ritrasmesso come un feed RTSP stabile, compatibile anche con **MotionEye**.

## Funzionalità
- ✅ **Recupera dinamicamente il flusso RTSP** dall'API Google
- ✅ **Ritrasmette il feed RTSP tramite GStreamer** per una maggiore stabilità
- ✅ **Rinnova automaticamente l'URL RTSP** prima della scadenza
- ✅ **Compatibile con Home Assistant OS (Hassio) e MotionEye**
- ✅ **Supporta architetture ARM64 (Raspberry Pi 4), AMD64 e altre**
- ✅ **Piena compatibilità del Relay stream rstp con Motioneye e VLC**

## Installazione

### 1️⃣ Installare l'Add-on
1. **Vai su Home Assistant** → **Impostazioni** → **Componenti aggiuntivi**.
2. Clicca su **"Negozio Componenti Aggiuntivi"**.
3. Clicca su **"Repository"** in basso a destra.
4. Inserisci l'URL del repository: `https://github.com/GiuseppePlacanica/hassio-nest-stream`
5. Clicca su **"Aggiungi"**, poi trova e installa **Nest Stream**.

### 3️⃣ Configurare l'Add-on
Modifica le opzioni di configurazione in **Home Assistant** sotto **Configurazioni** → **Componenti aggiuntivi** → **Nest Stream**:

```json
{
  "client_id": "YOUR_CLIENT_ID",
  "client_secret": "YOUR_CLIENT_SECRET",
  "refresh_token": "YOUR_REFRESH_TOKEN",
  "project_id": "YOUR_PROJECT_ID",
  "device_id": "YOUR_DEVICE_ID",
  "stream_port": 8554
}
```

### 4️⃣ Avviare l'Add-on
- Clicca su **Avvia**.
- Controlla i log per verificare che lo streaming sia in esecuzione.

### 5️⃣ Aggiungere la Camera a Home Assistant e MotionEye
Vai su **Impostazioni** → **Integrazioni** → **Generic RTSP Camera** e utilizza:
```
rtsp://<TUO_IP_HOME_ASSISTANT>:<STREAM_PORT>/live
```
Se usi **MotionEye**, puoi aggiungere la camera inserendo lo stesso URL nella configurazione della nuova telecamera.

## Obtaining the Required Parameters
Se vuoi ottenere i parametri per configurare lo streaming della camera segui la sezione sopra -> *Obtaining the Required Parameters*

## Dettagli di Configurazione

### Variabili d'Ambiente Utilizzate
| Variabile        | Descrizione |
|-----------------|-------------|
| `client_id`    | Google API Client ID |
| `client_secret` | Google API Client Secret |
| `refresh_token` | OAuth Refresh Token |
| `project_id`   | Google Smart Device Management Project ID |
| `device_id`    | Nest Camera Device ID |
| `stream_port`  | Porta su cui gira il relay RTSP (default: 8554) |

## Risoluzione Problemi

### ❌ Il Flusso RTSP Non Appare in HA o MotionEye
- Controlla i log nella scheda log

### ❌ Problemi con l'API
- Assicurati che le **credenziali OAuth di Google** siano corrette.
- Verifica che **il tuo dispositivo Nest supporti lo streaming RTSP** nell'app Google Home o Nest.

## Contributi
Sentiti libero di **fare fork** del repository e inviare **pull request**! 🚀
