#!/bin/bash

SCREEN_STATE_FILE="$HOME/.config/screen-state"

# Detectar entorno
if [[ -n "$SWAYSOCK" ]]; then
  WM="sway"
elif [[ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]]; then
  WM="hyprland"
else
  notify-send "Error" "No se detectó Sway ni Hyprland"
  exit 1
fi

# Leer estado actual
if [[ -f "$SCREEN_STATE_FILE" ]]; then
  current_screen=$(cat "$SCREEN_STATE_FILE")
else
  current_screen="screen1"
fi

# Funciones Sway
apply_sway_screen1() {
  swaymsg output eDP-1 resolution 1366x768@60Hz position 0 0
  swaymsg output HDMI-A-1 resolution 1920x1080@60Hz position 1366 0
}

apply_sway_screen2() {
  swaymsg output HDMI-A-1 resolution 1920x1080 position 0 0
  swaymsg output eDP-1 resolution 1366x768 position 1920 0
}

# Funciones Hyprland
apply_hypr_screen1() {
  hyprctl keyword monitor "HDMI-A-1,preferred,0x0,1"
  sleep 0.2

  WIDTH=$(hyprctl monitors -j | jq -r '.[] | select(.name=="HDMI-A-1") | .width')
  hyprctl keyword monitor "eDP-1,preferred,${WIDTH}x0,1"

  # 🔥 FIX REAL
  hyprctl dispatch dpms off
  sleep 0.3
  hyprctl dispatch dpms on
  sleep 0.3
  hyprctl dispatch movecursor 0 0
}

apply_hypr_screen2() {
  hyprctl keyword monitor "eDP-1,preferred,0x0,1"
  sleep 0.2

  WIDTH=$(hyprctl monitors -j | jq -r '.[] | select(.name=="eDP-1") | .width')
  hyprctl keyword monitor "HDMI-A-1,preferred,${WIDTH}x0,1"

  # 🔥 FIX REAL
  hyprctl dispatch dpms off
  sleep 0.3
  hyprctl dispatch dpms on
  sleep 0.3
  hyprctl dispatch movecursor 0 0
}

# Toggle
if [[ "$current_screen" == "screen1" ]]; then
  echo "screen2" >"$SCREEN_STATE_FILE"

  if [[ "$WM" == "sway" ]]; then
    apply_sway_screen2
  else
    apply_hypr_screen2
  fi

  notify-send "Configuración: HDMI principal ($WM)"

else
  echo "screen1" >"$SCREEN_STATE_FILE"

  if [[ "$WM" == "sway" ]]; then
    apply_sway_screen1
  else
    apply_hypr_screen1
  fi

  notify-send "Configuración: Laptop principal ($WM)"
fi
