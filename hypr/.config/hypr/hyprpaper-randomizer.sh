#!/usr/bin/env bash

# Check if hyprpaper is running
if ! pgrep -x "hyprpaper" > /dev/null; then
    # Start hyprpaper if not running
    hyprpaper &
    notify-send "Hyprpaper" "Hyprpaper has been started"
fi

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
matugen image "$WALLPAPER"
