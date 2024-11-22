#!/bin/bash
#swap Installomator with company-managed version - *should* avoid issues with app labels

# Define variables
TARGET_PATH="/usr/local/Installomator/Installomator.sh"
REMOTE_URL="https://raw.githubusercontent.com/jarrettwalkerassociates/Installomator/refs/heads/main/Installomator.sh"
BACKUP_PATH="${TARGET_PATH}.backup"

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo"
    exit 1
fi

# Create backup of existing file
if [ -f "$TARGET_PATH" ]; then
    echo "Creating backup of existing Installomator script..."
    cp "$TARGET_PATH" "$BACKUP_PATH" || {
        echo "Failed to create backup"
        exit 1
    }
fi

# Download and verify new script
echo "Downloading new Installomator script..."
curl -s -L "$REMOTE_URL" -o "${TARGET_PATH}.tmp" || {
    echo "Download failed"
    rm -f "${TARGET_PATH}.tmp"
    exit 1
}

# Verify the downloaded file is not empty
if [ ! -s "${TARGET_PATH}.tmp" ]; then
    echo "Downloaded file is empty"
    rm -f "${TARGET_PATH}.tmp"
    exit 1
fi

# Replace the original file
mv "${TARGET_PATH}.tmp" "$TARGET_PATH" || {
    echo "Failed to replace script"
    rm -f "${TARGET_PATH}.tmp"
    exit 1
}

# Set proper permissions
chmod 755 "$TARGET_PATH" || {
    echo "Failed to set permissions"
    exit 1
}

echo "Installomator script updated successfully"