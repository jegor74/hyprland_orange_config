#!/bin/bash

options="\n󰑓\n\n󰗽"
 
selected=$(echo -e $options | wofi \
       	--show dmenu \
	--cache-file /dev/null \
       	--conf=/home/jegor/.config/wofi/powermenu_conf \
       	--style=/home/jegor/.config/wofi/powermenu_style.css)
 
case $selected in
    "") cliphist wipe && systemctl poweroff;;
    "󰑓") cliphist wipe && systemctl reboot;;
    "") hyprlock;;
    "󰗽") cliphist wipe && hyprctl dispatch exit;;
esac
