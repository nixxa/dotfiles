#!/bin/sh

card_id=$(cat /proc/asound/cards | grep J370 | awk -F' ' '{print $1}')
amixer -c $card_id set PCM $1

current_brightness=$(brightnessctl --device='platform::mute' get)
if [ "toggle" == "$1" ]; then
    if [ "1" == "$current_brightness" ]; then
        brightnessctl --device='platform::mute' set 0
    else
        brightnessctl --device='platform::mute' set 1
    fi
fi
