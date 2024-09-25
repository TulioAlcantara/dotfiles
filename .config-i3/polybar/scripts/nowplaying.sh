#!/usr/bin/env bash

playerctlstatus=$(playerctl status 2> /dev/null)

if [[ $playerctlstatus ==  "" ]]; then
    echo ""
elif [[ $playerctlstatus =~ "Playing" ]]; then
    echo  $(playerctl metadata --format "{{title}}")
else
    echo  $(playerctl metadata --format "{{title}}")
fi
