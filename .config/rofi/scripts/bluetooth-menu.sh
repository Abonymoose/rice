#!/bin/sh
# rofi custom mode: lists paired Bluetooth devices, toggles connect/disconnect.
# Usage: rofi -show bluetooth -modi "bluetooth:~/.config/rofi/scripts/bluetooth-menu.sh"

selected="$1"

list_devices() {
    bluetoothctl paired-devices 2>/dev/null | while read -r _ mac name; do
        if bluetoothctl info "$mac" 2>/dev/null | grep -q "Connected: yes"; then
            state="Connected"
        else
            state="Disconnected"
        fi
        echo "$mac  $name  [$state]"
    done
}

if [ -z "$selected" ]; then
    if ! command -v bluetoothctl >/dev/null 2>&1; then
        echo "bluetoothctl not found"
        exit 0
    fi
    devices=$(list_devices)
    if [ -z "$devices" ]; then
        echo "No paired devices"
    else
        printf '%s\n' "$devices"
    fi
    exit 0
fi

mac=$(printf '%s' "$selected" | awk '{print $1}')

case "$selected" in
    *"[Connected]")
        bluetoothctl disconnect "$mac" >/dev/null 2>&1
        ;;
    *"[Disconnected]")
        bluetoothctl connect "$mac" >/dev/null 2>&1
        ;;
esac

devices=$(list_devices)
if [ -z "$devices" ]; then
    echo "No paired devices"
else
    printf '%s\n' "$devices"
fi
