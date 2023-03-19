#!/bin/bash
FILE="$HOME/.cache/eww_launch.dashboard"
CFG="$HOME/.config/eww/dashboard"

 
if [[ ! -f "$FILE" ]]; then
	touch "$FILE"
	eww --config "$CFG" open dashboard
 else
    rm "$FILE"
 	eww --config "$CFG" close dashboard
 fi
