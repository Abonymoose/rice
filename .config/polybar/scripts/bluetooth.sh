#!/bin/sh
# Prints ON if bluetooth is powered, OFF otherwise. Requires bluetoothctl.
if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
    echo "BT ON"
else
    echo "BT OFF"
fi
