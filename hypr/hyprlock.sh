#!/usr/bin/env bash

# ————————————————
# Hyprlock initialization
# where each lock invocation picks a random fresh background
# before locking the screen.
# ————————————————

set -euo pipefail

# ─── CONFIG ────────────────────────────────────────────────────────────────
CONF="$HOME/.config/hypr/hyprlock.conf"
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
# ────────────────────────────────────────────────────────────────────────────

# 1) read the current wallpaper value from the $wall assignment in the config
#    handles quoted or unquoted values
current=$(sed -nE 's/^[[:space:]]*\$wall[[:space:]]*=[[:space:]]*"?([^"]+)"?/\1/p' "$CONF")

if [[ -z "$current" ]]; then
  echo "❌ Could not find '\$wall = ...' in $CONF" >&2
  exit 1
fi

# 2) gather all files in the wallpapers folder
mapfile -t all_images < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f)

# 3) exclude the current one
mapfile -t candidates < <(
  for img in "${all_images[@]}"; do
    [[ "$img" != "$current" ]] && printf '%s\n' "$img"
  done
)

if (( ${#candidates[@]} == 0 )); then
  echo "⚠️  No alternative wallpapers found in $WALLPAPER_DIR" >&2
  exit 1
fi

# 4) pick a random one
new_wallpaper=$(printf '%s\n' "${candidates[@]}" | shuf -n1)

# 5) replace the $wall assignment in the config (preserve literal "$wall = ")
awk -v nw="$new_wallpaper" '
  /^[[:space:]]*\$wall[[:space:]]*=/ {
    print "$wall = " nw
    next
  }
  { print }
' "$CONF" > "$CONF.tmp" && mv "$CONF.tmp" "$CONF"

echo "🔄 Updated wallpaper constant in $CONF:"
echo "   old: $current"
echo "   new: $new_wallpaper"
echo "   Locking Screen now..."

sleep 1

hyprlock &