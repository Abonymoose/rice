#!/bin/sh
# Prints BT: on/off. Requires bluetoothctl. Plain text, no icon fonts.
if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
    echo "BT: on"
else
    echo "BT: off"
fi
