#!/bin/bash

FILE=~/Pictures/screenshots/screenshot_$(date +%F_%T).png

if [ "$1" = "area" ]; then
  GEOM=$(slurp)
  [ -z "$GEOM" ] && exit 1 # Salir si el usuario cancela
  grim -g "$GEOM" "$FILE"
else
  grim "$FILE"
fi

wl-copy <"$FILE"
