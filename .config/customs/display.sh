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

# Helper para mover el cursor al centro del monitor primario en Hyprland
hypr_move_cursor_to_monitor_center() {
  local MONITOR="$1"
  local DATA
  DATA=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$MONITOR\") | {x: .x, y: .y, w: .width, h: .height}")
  local X Y W H
  X=$(echo "$DATA" | jq -r '.x')
  Y=$(echo "$DATA" | jq -r '.y')
  W=$(echo "$DATA" | jq -r '.w')
  H=$(echo "$DATA" | jq -r '.h')

  if [[ -n "$X" && "$X" != "null" && -n "$W" && "$W" != "null" ]]; then
    local CENTER_X=$((X + W / 2))
    local CENTER_Y=$((Y + H / 2))
    hyprctl dispatch movecursor "$CENTER_X" "$CENTER_Y"
  fi
}

# Helper para mover workspaces a sus monitores correspondientes
# workspace 1 → monitor primario, workspace 2 → monitor secundario
hypr_assign_workspaces() {
  local PRIMARY="$1"
  local SECONDARY="$2"

  # Mover workspace 1 al monitor primario
  hyprctl dispatch moveworkspacetomonitor "1" "$PRIMARY"
  sleep 0.1
  # Mover workspace 2 al monitor secundario
  hyprctl dispatch moveworkspacetomonitor "2" "$SECONDARY"
  sleep 0.1

  # También mueve los workspaces comunes a donde tenga sentido
  # Los workspaces 3-9 van al primario
  for ws in 3 4 5 6 7 8 9 10; do
    hyprctl dispatch moveworkspacetomonitor "$ws" "$PRIMARY"
  done
}

# Obtener el ancho de un monitor desde hyprctl
hypr_get_monitor_width() {
  local MONITOR="$1"
  hyprctl monitors -j | jq -r ".[] | select(.name==\"$MONITOR\") | .width // empty"
}

# Funciones Hyprland
apply_hypr_screen1() {
  # Layout: HDMI a la izquierda, eDP (laptop) a la derecha
  # "Laptop principal" = el foco está en la laptop (eDP)
  #
  # Resoluciones reales:
  #   eDP-1  (laptop): 1920x1200 @ 1.2x scale (para que la letra se vea bien)
  #   HDMI-A-1:        1920x1080 @ 1.0x scale

  # Primero poner HDMI a la izquierda
  hyprctl keyword monitor "HDMI-A-1,1920x1080@60,0x0,1"
  sleep 0.3

  # eDP a la derecha de HDMI (posición X = 1920)
  hyprctl keyword monitor "eDP-1,1920x1200@60,1920x0,1.5"
  sleep 0.3

  # Asignar workspaces: primario=eDP (laptop), secundario=HDMI
  hypr_assign_workspaces "eDP-1" "HDMI-A-1"

  # Mover cursor al centro de la laptop (monitor primario)
  hypr_move_cursor_to_monitor_center "eDP-1"

  # Enfocar la laptop
  hyprctl dispatch focusmonitor "eDP-1"
}

apply_hypr_screen2() {
  # Layout: eDP (laptop) a la izquierda, HDMI a la derecha
  # "HDMI principal" = el foco está en HDMI
  #
  # Resoluciones reales:
  #   eDP-1  (laptop): 1920x1200 @ 1.2x scale (para que la letra se vea bien)
  #   HDMI-A-1:        1920x1080 @ 1.0x scale

  # Primero poner eDP a la izquierda
  hyprctl keyword monitor "eDP-1,1920x1200@60,0x0,1.5"
  sleep 0.3

  # HDMI a la derecha de eDP (posición X = 1920)
  hyprctl keyword monitor "HDMI-A-1,1920x1080@60,1920x0,1"
  sleep 0.3

  # Asignar workspaces: primario=HDMI, secundario=eDP
  hypr_assign_workspaces "HDMI-A-1" "eDP-1"

  # Mover cursor al centro de HDMI (monitor primario)
  hypr_move_cursor_to_monitor_center "HDMI-A-1"

  # Enfocar HDMI
  hyprctl dispatch focusmonitor "HDMI-A-1"
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
