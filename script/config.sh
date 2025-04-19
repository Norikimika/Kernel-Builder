#!/bin/bash

CONFIG_PATH="${DEFCONFIG:-out/.config}"
input="$1"

if [[ "$input" =~ ^#\ (.+)\ is\ not\ set$ ]]; then
    key="${BASH_REMATCH[1]}"
    # Remove both forms: "# KEY is not set" and "KEY=..."
    sed -i "/^# *$key is not set/d" "$CONFIG_PATH"
    sed -i "/^$key=.*/d" "$CONFIG_PATH"
elif [[ "$input" == *=* ]]; then
    key="${input%%=*}"
    sed -i "/^# *$key is not set/d" "$CONFIG_PATH"
    sed -i "/^$key=.*/d" "$CONFIG_PATH"
else
    echo "Invalid input format: $input" >&2
    exit 1
fi

# Only append if the line doesn't already exist
if ! grep -Fxq "$input" "$CONFIG_PATH"; then
    echo "$input" >> "$CONFIG_PATH"
fi