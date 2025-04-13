#!/bin/bash

CONFIG_PATH="${DEFCONFIG:-out/.config}"

input="$1"
key="${input%%=*}" 
value="${input#*=}"

if grep -q "^# $key is not set" "$CONFIG_PATH"; then
    sed -i "/^# $key is not set/d" "$CONFIG_PATH"
    echo "$key=$value" >> "$CONFIG_PATH"
elif grep -q "^$key=" "$CONFIG_PATH"; then
    sed -i "s/^$key=.*/$key=$value/" "$CONFIG_PATH"
else
    echo "$key=$value" >> "$CONFIG_PATH"
fi