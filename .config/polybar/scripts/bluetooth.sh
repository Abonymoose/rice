#!/bin/sh
# Prints BLU on/off. Requires bluetoothctl.
if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
    echo "BLU on"
else
    echo "BLU off"
fi
