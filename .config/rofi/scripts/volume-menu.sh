#!/bin/sh
# rofi custom mode: volume up/down/mute, shows current volume %.
# Usage: rofi -show volume -modi "volume:~/.config/rofi/scripts/volume-menu.sh"

selected="$1"

current_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | awk '{print $5; exit}'
}

is_muted() {
    pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}'
}

print_menu() {
    vol=$(current_volume)
    if [ "$(is_muted)" = "yes" ]; then
        status="Muted (${vol:-?})"
    else
        status="${vol:-?}"
    fi
    echo "Current: $status"
    echo "Volume Up (+5%)"
    echo "Volume Down (-5%)"
    echo "Toggle Mute"
}

if [ -z "$selected" ]; then
    if ! command -v pactl >/dev/null 2>&1; then
        echo "pactl not found"
        exit 0
    fi
    print_menu
    exit 0
fi

case "$selected" in
    "Volume Up"*)
        pactl set-sink-volume @DEFAULT_SINK@ +5% >/dev/null 2>&1
        ;;
    "Volume Down"*)
        pactl set-sink-volume @DEFAULT_SINK@ -5% >/dev/null 2>&1
        ;;
    "Toggle Mute")
        pactl set-sink-mute @DEFAULT_SINK@ toggle >/dev/null 2>&1
        ;;
esac

print_menu
