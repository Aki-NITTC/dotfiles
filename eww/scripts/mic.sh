#!/bin/bash
get_mic() {
    while true; do
  	    pactl get-source-volume @DEFAULT_SOURCE@ | grep -e '%' | sed 's/ //g' | cut -d "/" -f 2 | sed 's/%//'
	done
}

set_mic() {
    pactl set-source-volume @DEFAULT_SOURCE@ $1%
}

toggle_mic() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
}

get_mic_icon() {
    while true; do
        MUTE="$(pactl get-source-mute @DEFAULT_SOURCE@)"
        if [[ "$MUTE" == "Mute: no" ]]; then
            echo ""
  	    else
    	    echo ""
  	    fi
	done
}

if [[ "$1" == "--get" ]]; then
    get_mic
elif [[ "$1" == "--set" ]]; then
	set_mic "$2"
elif [[ "$1" == "--toggle" ]]; then
	toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
	get_mic_icon
fi
