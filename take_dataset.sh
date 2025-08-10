#!/bin/bash

URL_FILE="datasets.txt"
DOWNLOAD_DIR="downloads"
mkdir -p "$DOWNLOAD_DIR"

while true
do
    # Pick random dataset URL from file
    URL=$(shuf -n 1 "$URL_FILE")
    FILE_NAME=$(basename "$URL")

    echo "📥 Downloading: $URL"
    curl -L --progress-bar "$URL" -o "$DOWNLOAD_DIR/$FILE_NAME"

    if [ -f "$DOWNLOAD_DIR/$FILE_NAME" ]; then
        echo "✅ Download complete: $FILE_NAME"
        FILE_SIZE=$(du -h "$DOWNLOAD_DIR/$FILE_NAME" | cut -f1)
        echo "File size: $FILE_SIZE"

        echo "🗑 Deleting file..."
        rm -f "$DOWNLOAD_DIR/$FILE_NAME"
    else
        echo "⚠ Download failed: $URL"
    fi

    echo "⏳ Waiting 10 seconds before next download..."
    sleep 10
done
