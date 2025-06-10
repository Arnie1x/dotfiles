#!/usr/bin/env bash

# ————————————————
# Random Wallpaper Setter
# using hyprpanel’s wallpaper implementation
# ————————————————

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
STATE_FILE="$WALLPAPER_DIR/.current_wallpaper"

# 1) Ensure hyprpanel is running
if ! pgrep -x "gjs" > /dev/null; then
    hyprpanel &
    notify-send "HyprPanel" "HyprPanel daemon started"
fi

# 2) Read last wallpaper (if any)
if [[ -f "$STATE_FILE" ]]; then
    LAST_WALL=$(<"$STATE_FILE")
    LAST_NAME=$(basename "$LAST_WALL")
else
    LAST_NAME=""
fi

# 3) Pick a new random wallpaper ≠ last one
NEW_WALL=$(find "$WALLPAPER_DIR" -type f ! -name "$LAST_NAME" | shuf -n1)

# 4) Apply it via hyprpanel
hyprpanel setWallpaper "$NEW_WALL"

# 5) Save this choice for next time
echo "$NEW_WALL" >"$STATE_FILE"
