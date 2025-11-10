#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Command to set the wallpaper (using feh as an example)
# Replace 'feh --bg-scale' with the command for your utility (e.g., 'swww img', 'nitrogen --set-auto')
SET_WALLPAPER_CMD="feh --bg-scale"

# Use find to list all image files in the directory and pipe to rofi
# -format "%f" gets the filename only, remove it to get full path in rofi
WALLPAPER_PATH=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | rofi -dmenu -i -p "Select Wallpaper:")

# Check if a wallpaper was selected (rofi returns empty if cancelled)
if [ -n "$WALLPAPER_PATH" ]; then
    # Set the wallpaper
    $SET_WALLPAPER_CMD "$WALLPAPER_PATH"
    # Optional: save the last used wallpaper for persistence after reboot
    echo "$WALLPAPER_PATH" > /tmp/last_wallpaper
fi
