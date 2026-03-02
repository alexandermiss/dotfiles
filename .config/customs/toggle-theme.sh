#!/bin/bash

# Archivo para guardar el estado actual
STATE_FILE="$HOME/.config/theme-state"

LIGHT_THEME="Catppuccin-Light-Frappe"
DARK_THEME="Catppuccin-Dark-Macchiato"

LIGHT_QT="Catppuccin-Light-Frappe"
DARK_QT="Catppuccin-Dark-Macchiato"

LIGHT_BG="/home/me/Pictures/walls/psalm88_3_6.png"
DARK_BG="/home/me/Pictures/walls/psalm88_3_6.png"

# Leer estado actual
if [[ -f "$STATE_FILE" ]]; then
  current=$(cat "$STATE_FILE")
else
  current="light"
fi

# Alternar estado
if [[ "$current" == "light" ]]; then
  echo "dark" >"$STATE_FILE"
  export GTK_THEME="Catppuccin-Dark-Macchiato"
  sed -i 's/^gtk-theme-name=.*/gtk-theme-name=Catppuccin-Dark-Macchiato/' ~/.config/gtk-4.0/settings.ini
  sed -i "/^gtk-application-prefer-dark-theme=/c\gtk-application-prefer-dark-theme=1" ~/.config/gtk-4.0/settings.ini
  gsettings set org.gnome.desktop.interface gtk-theme "$DARK_THEME"
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  swaymsg output "*" bg "$DARK_BG" fill
  export QT_STYLE_OVERRIDE="$DARK_QT"

  cp "$HOME/.config/foot/mocha.ini" "$HOME/.config/foot/foot.ini"
  cp "$HOME/.config/wofi/style-dark.css" "$HOME/.config/wofi/style.css"
else
  echo "light" >"$STATE_FILE"
  export GTK_THEME="Catppuccin-Light-Frappe"
  sed -i 's/^gtk-theme-name=.*/gtk-theme-name=Catppuccin-Light-Frappe/' ~/.config/gtk-4.0/settings.ini
  sed -i "/^gtk-application-prefer-dark-theme=/c\gtk-application-prefer-dark-theme=0" ~/.config/gtk-4.0/settings.ini
  export GTK_THEME="Adwaita"
  gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_THEME"
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  swaymsg output "*" bg "$LIGHT_BG" fill
  export QT_STYLE_OVERRIDE="$LIGHT_QT"

  cp "$HOME/.config/foot/latte.ini" "$HOME/.config/foot/foot.ini"
  cp "$HOME/.config/wofi/style-light.css" "$HOME/.config/wofi/style.css"
fi
