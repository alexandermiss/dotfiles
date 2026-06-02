#!/bin/bash

# acpi | cut -d, -f 2 | xargs

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

# Define icon and color based on capacity
if [ "$status" = "Charging" ]; then
  icon="⚡"
  color="#42be65"
elif [ "$capacity" -le 15 ]; then
  icon=""
  color="#da1e28"
elif [ "$capacity" -le 30 ]; then
  icon=""
  color="#ff8389"
elif [ "$capacity" -le 50 ]; then
  icon=""
  color="#f1c21b"
elif [ "$capacity" -le 70 ]; then
  icon=""
  color="#f1c21b"
else
  icon=""
  color="#42be65"
fi

echo "<span color='$color'>$icon $capacity%</span>"
