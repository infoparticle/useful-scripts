#!/bin/bash

# Configuration
URL="https://github.com/infoparticle/useful-scripts/raw/refs/heads/main/resources/obsidian/obsidian-template.zip"
ZIP_FILE="obsidian-template.zip"
TEMP_DIR="obsidian-template"
DEFAULT_NAME="obsidian-vault-$(date +%F)"

# 1. Get the new vault name
read -p "Enter your new Obsidian vault name [Default: $DEFAULT_NAME]: " VAULT_NAME

# Use default if input is empty
VAULT_NAME=${VAULT_NAME:-$DEFAULT_NAME}

# 2. Fetch the zip, s-silent, S-show errors, L-follow redirect
echo "Downloading template..."
curl -sSL $URL -o $ZIP_FILE

# 3. Unzip
echo "Extracting..."
unzip -q $ZIP_FILE -d $TEMP_DIR

# 4. Rename and Cleanup
if [ -d "$TEMP_DIR" ]; then
    mv "$TEMP_DIR" "$VAULT_NAME"
    rm $ZIP_FILE
    echo "Success! Vault created at: ./$VAULT_NAME"
else
    # Fallback in case the zip contains files directly instead of a subfolder
    echo "Check: Did the zip contain a '$TEMP_DIR' folder?"
fi
