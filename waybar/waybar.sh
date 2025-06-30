#!/bin/bash
# This script toggles the Waybar status bar on and off.
if pgrep -x "waybar" > /dev/null; then
    killall waybar
else
    waybar &
fi