#!/bin/bash

# Get the current battery percentage
battery_percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "percentage:" | awk '{print $2}')

# Get the battery status (Charging or Discharging)
battery_status=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state:" | awk '{print $2}')

# Define the battery icons for each 10% segment
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon="󰂄"

# Strip trailing '%' and any whitespace, then calculate the index
battery_percentage_num=${battery_percentage%\%}
battery_percentage_num=${battery_percentage_num//[[:space:]]/}
icon_index=$((battery_percentage_num / 10))

# Get the corresponding icon
battery_icon=${battery_icons[icon_index]}

# Check if the battery is charging
if [ "$battery_status" = "charging" ]; then
	battery_icon="$charging_icon"
fi

# Output the battery percentage and icon
echo "$battery_icon $battery_percentage" 
