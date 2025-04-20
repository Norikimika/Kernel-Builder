#!/bin/bash

PATCH="$1"

# Extract target file path from the patch
TARGET_FILE=$(grep '^--- ' "$PATCH" | awk '{print $2}' | sed 's|^a/||; s|^b/||' | sed 's|^/||')

# Backup the target file if it exists
if [[ -f "$TARGET_FILE" ]]; then
  cp "$TARGET_FILE" "$TARGET_FILE.bak"
  echo "[*] Backup created: $TARGET_FILE.bak"
else
  echo "[!] Target file not found: $TARGET_FILE"
fi

# Try applying the patch
echo "[*] Applying patch: $PATCH"
if patch -p1 < "$PATCH"; then
  echo "[✓] Patch applied successfully"
  [[ -f "$TARGET_FILE.bak" ]] && rm -f "$TARGET_FILE.bak"
  exit 0
else
  echo "[!] Patch failed"
  if [[ -f "$TARGET_FILE.bak" ]]; then
    mv "$TARGET_FILE.bak" "$TARGET_FILE"
    echo "[*] Original file restored from backup"
  fi
  exit 0
fi