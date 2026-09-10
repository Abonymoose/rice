#!/bin/sh
# Volume control, 100% rofi. Type 0-100 and press Enter to set the
# volume instantly. Bound to $mod+Shift+v in i3, and discoverable via
# rofi drun as "Volume Manager" through volume-manager.desktop.

ROFI_CONF="$HOME/.config/rofi/config.rasi"

notify() {
    printf '%s\n' "$1" | rofi -dmenu -p "Volume" -config "$ROFI_CONF" >/dev/null
}

current_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | awk '{print $5}' | head -1 | tr -d '%'
}

if ! command -v rofi >/dev/null 2>&1; then
    echo "rofi not found" >&2
    exit 1
fi
if ! command -v pactl >/dev/null 2>&1; then
    notify "pactl not found"
    exit 1
fi

cur=$(current_volume)
input=$(printf '%s\n' "${cur:-0}" | rofi -dmenu -p "Volume (0-100, current ${cur:-?})" -config "$ROFI_CONF")

[ -z "$input" ] && exit 0

case "$input" in
    ''|*[!0-9]*)
        notify "Invalid input: $input"
        exit 1
        ;;
esac

if [ "$input" -gt 100 ]; then
    notify "Out of range (0-100): $input"
    exit 1
fi

pactl set-sink-volume @DEFAULT_SINK@ "${input}%" >/dev/null 2>&1
pactl set-sink-mute @DEFAULT_SINK@ 0 >/dev/null 2>&1
