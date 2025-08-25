#!/bin/bash

# Changes the Color of Niri's Focus Ring to match the current wallpaper based on Pywal

CONFIG_FILE="/home/arnie/.config/niri/config.kdl"
if [ ! -f "${CONFIG_FILE}.tmp" ]; then
    touch "${CONFIG_FILE}.tmp"
fi

if [ -f "$HOME/.cache/wal/colors.sh" ]; then
    source "$HOME/.cache/wal/colors.sh"
    COLOR1="$color7"
    COLOR2="$color4"
else
    echo "Run wal first to generate colors at ~/.cache/wal/colors.sh"
    exit 1
fi

# Pattern to match the active-gradient line
PATTERN='^[[:space:]]*active-gradient[[:space:]]+from="[^"]*"[[:space:]]+to="[^"]*".*$'

# New line to write
NEW_LINE="active-gradient from=\"$COLOR1\" to=\"$COLOR2\" angle=45 relative-to=\"workspace-view\""

# Use awk to replace only the first matching line
awk -v newline="$NEW_LINE" -v pat="$PATTERN" '
    !found && $0 ~ pat { print newline; found=1; next }
    { print }
' "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"