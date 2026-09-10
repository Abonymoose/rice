#!/bin/sh
# Bluetooth menu, 100% rofi (no zenity/GTK). Uses the same config.rasi
# as the app launcher, so colors/opacity/font are identical, not
# approximated. Bound to $mod+Shift+b in i3, and discoverable via rofi drun as
# "Bluetooth Manager" through bluetooth-manager.desktop.

ROFI_CONF="$HOME/.config/rofi/config.rasi"
PROMPT="Bluetooth"

# Auto-power on Bluetooth if needed
bluetoothctl power on 2>/dev/null

# Shows a plain rofi -dmenu list built from the given lines; prints
# the selected line, or nothing if cancelled.
rofi_menu() {
    p="$1"
    shift
    printf '%s\n' "$@" | rofi -dmenu -p "$p" -config "$ROFI_CONF"
}

notify() {
    rofi_menu "$PROMPT" "$1" >/dev/null
}

list_paired() {
    bluetoothctl paired-devices 2>/dev/null | while read -r _ mac name; do
        printf '%s  %s\n' "$mac" "$name"
    done
}

list_connected() {
    bluetoothctl devices Connected 2>/dev/null | while read -r _ mac name; do
        printf '%s  %s\n' "$mac" "$name"
    done
}

list_discovered() {
    bluetoothctl devices 2>/dev/null | while read -r _ mac name; do
        printf '%s  %s\n' "$mac" "$name"
    done
}

# Prints the chosen MAC on stdout, or nothing if cancelled/empty.
pick_device() {
    listing="$1"
    if [ -z "$listing" ]; then
        notify "No devices found"
        return 1
    fi
    selected=$(printf '%s\n' "$listing" | rofi -dmenu -p "$PROMPT" -config "$ROFI_CONF")
    [ -z "$selected" ] && return 1
    printf '%s' "$selected" | awk '{print $1}'
}

do_scan() {
    ( bluetoothctl scan on >/dev/null 2>&1 & SCAN_PID=$!
      sleep 5
      kill "$SCAN_PID" 2>/dev/null
      bluetoothctl scan off >/dev/null 2>&1 )
    mac=$(pick_device "$(list_discovered)")
    if [ -n "$mac" ]; then
        bluetoothctl connect "$mac" >/dev/null 2>&1
        notify "Connect attempted"
    fi
}

do_connect() {
    mac=$(pick_device "$(list_paired)")
    if [ -n "$mac" ]; then
        bluetoothctl connect "$mac" >/dev/null 2>&1
        notify "Connect attempted"
    fi
}

do_disconnect() {
    mac=$(pick_device "$(list_connected)")
    if [ -n "$mac" ]; then
        bluetoothctl disconnect "$mac" >/dev/null 2>&1
        notify "Disconnected"
    fi
}

do_power() {
    if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
        bluetoothctl power off >/dev/null 2>&1
        notify "Bluetooth powered off"
    else
        bluetoothctl power on >/dev/null 2>&1
        notify "Bluetooth powered on"
    fi
}

if ! command -v rofi >/dev/null 2>&1; then
    echo "rofi not found" >&2
    exit 1
fi
if ! command -v bluetoothctl >/dev/null 2>&1; then
    notify "bluetoothctl not found"
    exit 1
fi

choice=$(rofi_menu "$PROMPT" "Scan" "Connect" "Disconnect" "Power")

case "$choice" in
    "Scan") do_scan ;;
    "Connect") do_connect ;;
    "Disconnect") do_disconnect ;;
    "Power") do_power ;;
esac
