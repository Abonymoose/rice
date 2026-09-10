#!/bin/sh
# Bluetooth GUI using zenity, styled to match the rofi rice theme.
# Bound to $mod+b in i3.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
THEME_SRC="$SCRIPT_DIR/zenity-theme/gtk-4.0/gtk.css"
THEME_DEST="$HOME/.config/gtk-4.0/gtk.css"

install_theme() {
    mkdir -p "$(dirname "$THEME_DEST")"
    if [ ! -f "$THEME_DEST" ] || ! cmp -s "$THEME_SRC" "$THEME_DEST"; then
        cp "$THEME_SRC" "$THEME_DEST"
    fi
}

TITLE="Bluetooth"
WIDTH=340
HEIGHT=280

list_paired() {
    bluetoothctl paired-devices 2>/dev/null | while read -r _ mac name; do
        printf '%s\t%s\n' "$mac" "$name"
    done
}

list_connected() {
    bluetoothctl devices Connected 2>/dev/null | while read -r _ mac name; do
        printf '%s\t%s\n' "$mac" "$name"
    done
}

list_discovered() {
    bluetoothctl devices 2>/dev/null | while read -r _ mac name; do
        printf '%s\t%s\n' "$mac" "$name"
    done
}

# Prints the chosen MAC on stdout, or nothing if cancelled/empty.
pick_device() {
    listing="$1"
    if [ -z "$listing" ]; then
        zenity --info --title="$TITLE" --text="No devices found." --width="$WIDTH" 2>/dev/null
        return 1
    fi
    set --
    while IFS="$(printf '\t')" read -r mac name; do
        [ -z "$mac" ] && continue
        set -- "$@" "$mac" "$name"
    done <<DEVEOF
$listing
DEVEOF
    zenity --list \
        --title="$TITLE" \
        --width="$WIDTH" --height="$HEIGHT" \
        --column="MAC" --column="Device" \
        --hide-column=1 --print-column=1 \
        "$@" 2>/dev/null
}

do_scan() {
    ( bluetoothctl scan on >/dev/null 2>&1 & SCAN_PID=$!
      sleep 5
      kill "$SCAN_PID" 2>/dev/null
      bluetoothctl scan off >/dev/null 2>&1 )
    mac=$(pick_device "$(list_discovered)")
    if [ -n "$mac" ]; then
        bluetoothctl connect "$mac" >/dev/null 2>&1
        zenity --info --title="$TITLE" --text="Connect attempted." --width="$WIDTH" 2>/dev/null
    fi
}

do_connect() {
    mac=$(pick_device "$(list_paired)")
    if [ -n "$mac" ]; then
        bluetoothctl connect "$mac" >/dev/null 2>&1
        zenity --info --title="$TITLE" --text="Connect attempted." --width="$WIDTH" 2>/dev/null
    fi
}

do_disconnect() {
    mac=$(pick_device "$(list_connected)")
    if [ -n "$mac" ]; then
        bluetoothctl disconnect "$mac" >/dev/null 2>&1
        zenity --info --title="$TITLE" --text="Disconnected." --width="$WIDTH" 2>/dev/null
    fi
}

do_power() {
    if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
        bluetoothctl power off >/dev/null 2>&1
        zenity --info --title="$TITLE" --text="Bluetooth powered off." --width="$WIDTH" 2>/dev/null
    else
        bluetoothctl power on >/dev/null 2>&1
        zenity --info --title="$TITLE" --text="Bluetooth powered on." --width="$WIDTH" 2>/dev/null
    fi
}

if ! command -v zenity >/dev/null 2>&1; then
    echo "zenity not found" >&2
    exit 1
fi
if ! command -v bluetoothctl >/dev/null 2>&1; then
    zenity --error --title="$TITLE" --text="bluetoothctl not found." --width="$WIDTH" 2>/dev/null
    exit 1
fi

install_theme
export GTK_THEME="Adwaita:dark"

choice=$(zenity --list \
    --title="$TITLE" \
    --width="$WIDTH" --height="$HEIGHT" \
    --hide-header \
    --column="Action" \
    "Scan Devices" \
    "Connect" \
    "Disconnect" \
    "Power On/Off" 2>/dev/null)

case "$choice" in
    "Scan Devices") do_scan ;;
    "Connect") do_connect ;;
    "Disconnect") do_disconnect ;;
    "Power On/Off") do_power ;;
esac
