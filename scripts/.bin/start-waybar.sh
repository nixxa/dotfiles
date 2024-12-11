#!/bin/sh

killall waybar

if [[ $USER = "nixxa" ]]; then
  waybar -c ~/.config/waybar/theme.config -s ~/.config/waybar/style.css &
else
  waybar &
fi
