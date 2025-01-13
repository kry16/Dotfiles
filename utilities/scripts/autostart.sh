#!/bin/bash

# killall mpd; mpd &
killall picom; picom -b
xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate "60" &
# nohup mpDris2 &> /dev/null &
nohup nm-applet &> /dev/null &
# /lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 
