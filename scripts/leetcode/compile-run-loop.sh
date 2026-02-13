#!/usr/bin/env bash

FILE=Main.java
CLASS_NAME=Main
LAST_MOD=""
OUTPUT_FILE="/tmp/output"

# Ensure the output file exists
touch "$OUTPUT_FILE"

while true; do
  if [ -f "$FILE" ]; then
    # Get the last modification timestamp
    CURRENT_MOD=$(stat -c %Y "$FILE")

        # Only run if the timestamp has changed
        if [ "$CURRENT_MOD" != "$LAST_MOD" ]; then
          if javac "$FILE" > "$OUTPUT_FILE" 2>&1; then
            java "$CLASS_NAME" >> "$OUTPUT_FILE" 2>&1
          fi

          clear
          # ANSI Colors
          GREEN='\033[0;32m'
          RED='\033[0;31m'
          NC='\033[0m' # No Color

          clear
          if grep -iq "error" "$OUTPUT_FILE"; then
            echo -e "${RED}● FAILED${NC} - [$(date +%H:%M:%S)]"
          else
            echo -e "${GREEN}● SUCCESS${NC} - [$(date +%H:%M:%S)]"
          fi
          echo
          cat "$OUTPUT_FILE"

          LAST_MOD=$CURRENT_MOD
        fi
      else
        echo "Waiting for $FILE..."
  fi

    # High-frequency poll (0.5 or 1 second)
    sleep 0.5
  done
