#!/bin/bash
get_volume() {
	while true; do
  	    pactl list sinks | grep '^[[:space:]]Volume:' | \
    	head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'
	    sleep 1
	done
}

set_volume() {
    pactl set-sink-volume @DEFAULT_SINK@ $1%
}

toggle_volume() {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
}

get_volume_icon() {
	while true; do
  	    MUTE="$(pactl get-sink-mute @DEFAULT_SINK@)"
  	    if [[ "$MUTE" == "Mute: no" ]]; then
	  	    echo "墳"
  	    else
    	    echo "婢"
  	    fi

		sleep 1
	done
}

if [[ "$1" == "--set" ]]; then
	set_volume "$2"
elif [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_volume
elif [[ "$1" == "--get-icon" ]]; then
	get_volume_icon
fi
