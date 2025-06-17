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

# 1) read the current wallpaper path
current=$(sed -nE 's/^[[:space:]]*path[[:space:]]*=[[:space:]]*(.*)/\1/p' "$CONF")

if [[ -z "$current" ]]; then
  echo "❌ Could not find 'path = ...' in $CONF" >&2
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

# 5) in-place replace the old path line with the new one
#    using | as delimiter to avoid conflicts with /
sed -i -E "s|^[[:space:]]*path[[:space:]]*=.*|    path = $new_wallpaper|" "$CONF"

echo "🔄 Updated wallpaper:"
echo "   old: $current"
echo "   new: $new_wallpaper"
echo "   Locking Screen now..."

sleep 1

hyprlock &