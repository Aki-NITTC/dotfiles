#!/bin/bash

get_backlight() {
	while true; do
  	    echo "$(brightnessctl get)"
    done
}

set_backlight() {
    brightnessctl set $1
}


if [[ "$1" == "--get" ]]; then
    get_backlight
elif [[ "$1" == "--set" ]]; then
    set_backlight "$2"
fi
