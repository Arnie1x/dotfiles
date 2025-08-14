#!/usr/bin/env bash

# Ensure swww daemon is running
if ! pgrep -f "swww-daemon" > /dev/null; then
    swww-daemon &
    exit 0
fi

CACHE_FILE="$HOME/.cache/current_swww_wallpaper"

# WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
WALLPAPER_DIR="$HOME/Pictures/GIFs"  # Change this to your wallpaper directory
PIXEL_ART_PATTERN="pixel-art"  # Change this to match your pixel art naming convention

# Load the last-used wallpaper (basename), if any
if [[ -f "$CACHE_FILE" ]]; then
    CURRENT_WALL=$(basename "$(cat "$CACHE_FILE")")
else
    CURRENT_WALL=""
fi
# Pick a random file that's different from the last one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$CURRENT_WALL" | shuf -n 1)

# Filter Changing
if [[ "$WALLPAPER" == *$PIXEL_ART_PATTERN* ]]; then
    FILTER="Nearest" # For pixel art GIFs
else
    FILTER="Mitchell"
fi

# Apply with a smooth zoom transition (adjust duration/type as you like)
swww img "$WALLPAPER" --transition-type grow --transition-duration 1 --transition-fps 60 --filter "$FILTER"

# Notify and save for next time
notify-send "Wallpaper Changed" "$(basename "$WALLPAPER")"
echo "$WALLPAPER" > "$CACHE_FILE"

# Your existing post-processing
# matugen image "$WALLPAPER"
