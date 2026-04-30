#!/bin/bash

status=$(playerctl -p deezer status)
meta=$(playerctl -p deezer metadata --format '{{ artist }} - {{ title }}')

if [ "$status" = "Playing" ]; then
  echo "▶ $meta"
elif [ "$status" = "Paused" ]; then
  echo "⏸ $meta"
else
  echo ""
fi
