#!/bin/bash
toggle_network() {
    if [ -z "$(nmcli connection show --active)" ];then
        nmcli radio wifi on
    else
        nmcli radio wifi off
    fi
}

get_icon() {
    while true; do
        if [ -z "$(nmcli connection show --active)" ];then
            echo "睊"
        else
            echo "直"
        fi
    done
}

get_status() {  
    while true; do
        if [ -z "$(nmcli connection show --active)" ];then
            echo "睊  Offline"
        else 
            echo "直  $(nmcli -t -f NAME connection show --active)"
        fi

    done
}



if [ "$1" == "--toggle" ]; then
  toggle_network
elif [ "$1" == "--get-icon" ]; then
  get_icon
elif [ "$1" == "--get-status" ]; then
  get_status
fi
