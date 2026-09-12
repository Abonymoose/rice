#!/bin/sh
# Power menu - logout, restart, shutdown, suspend

choice=$(echo -e "Logout\nRestart\nShutdown\nSuspend" | rofi -dmenu -p "Power: ")

case "$choice" in
    Logout) i3-msg exit ;;
    Restart) sudo reboot ;;
    Shutdown) sudo shutdown -h now ;;
    Suspend) systemctl suspend ;;
esac
