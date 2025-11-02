#!/usr/bin/env bash

# Detect connected displays
CONNECTED=$(xrandr | grep " connected" | cut -d" " -f1)

# Check which outputs are connected
INTERNAL="eDP-1-1"
EXTERNAL="HDMI-1-1"

if echo "$CONNECTED" | grep -q "$EXTERNAL"; then
    echo "External monitor detected. Configuring dual screen..."
    xrandr --output $INTERNAL --mode 1920x1080 --pos 0x0 --rotate normal --primary \
           --output $EXTERNAL --mode 1920x1080 --pos 1920x0 --rotate normal

elif echo "$CONNECTED" | grep -q "$INTERNAL"; then
    echo "Only internal display detected. Configuring single screen..."
    xrandr --output $INTERNAL --mode 1920x1080 --pos 0x0 --rotate normal --primary \
           --output $EXTERNAL --off
else
    echo "No known displays detected."
    xrandr --output $INTERNAL --mode 1920x1080 --pos 0x0 --rotate normal --primary \
           --output $EXTERNAL --off
fi

