#!/bin/bash 
get_battery() {
    BAT=$(ls /sys/class/power_supply | grep BAT | head -n 1)
    echo "$(cat /sys/class/power_supply/${BAT}/capacity)%"
}

get_icon() {
    while true; do
        BAT=$(ls /sys/class/power_supply | grep BAT | head -n 1)
        BATSTATUS="$(cat /sys/class/power_supply/${BAT}/status)"
        BATVAL="$(cat /sys/class/power_supply/${BAT}/capacity)"

        if [[ "$BATSTATUS" == "Discharging" ]];then
            if [ "$BATVAL" -gt 90 ];then
                echo ""
            elif [ "$BATVAL" -gt 80 ];then
                echo ""
            elif [ "$BATVAL" -gt 70 ];then
                echo ""
            elif [ "$BATVAL" -gt 60 ];then
                echo ""
            elif [ "$BATVAL" -gt 50 ];then
                echo ""
            elif [ "$BATVAL" -gt 40 ];then
                echo ""
            elif [ "$BATVAL" -gt 30 ];then
                echo ""
            elif [ "$BATVAL" -gt 20 ];then
                echo ""
            elif [ "$BATVAL" -gt 10 ];then
                echo ""
            elif [ "$BATVAL" -gt 0 ];then
                echo ""
            fi
        else
            echo ""
        fi

        sleep 3
    done
}

get_percentage() {
    while true; do
        BAT=$(ls /sys/class/power_supply | grep BAT | head -n 1)
        echo "$(cat /sys/class/power_supply/${BAT}/capacity)%"
        sleep 3
    done
}

if [[ "$1" == "--get" ]]; then
	get_battery
elif [[ "$1" == "--get-icon" ]]; then
    get_icon
elif [[ "$1" == "--get-percentage" ]]; then
    get_percentage
fi
