#!/bin/bash

PATCH="$1"

# Extract all target file paths from the patch
TARGET_FILES=$(grep '^--- ' "$PATCH" | awk '{print $2}' | sed 's|^a/||; s|^b/||' | sed 's|^/||')

# Backup all target files
for FILE in $TARGET_FILES; do
  if [[ -f "$FILE" ]]; then
    cp "$FILE" "$FILE.bak"
    echo "[*] Backup created: $FILE.bak"
  else
    echo "[!] Target file not found: $FILE"
  fi
done

# Try applying the patch
echo "[*] Applying patch: $PATCH"
if patch -p1 < "$PATCH"; then
  echo "[✓] Patch applied successfully"
  # Remove backups
  for FILE in $TARGET_FILES; do
    [[ -f "$FILE.bak" ]] && rm -f "$FILE.bak"
  done
  exit 0
else
  echo "[!] Patch failed"
  # Restore from backups
  for FILE in $TARGET_FILES; do
    if [[ -f "$FILE.bak" ]]; then
      mv "$FILE.bak" "$FILE"
      echo "[*] Restored: $FILE"
    fi
  done
  exit 0
fi