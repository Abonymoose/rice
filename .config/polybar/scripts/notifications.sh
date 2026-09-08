#!/bin/sh
# Prints notification daemon (dunst) pause state. Requires dunstctl.
if dunstctl is-paused 2>/dev/null | grep -q "true"; then
    echo "MUTED"
else
    echo "NOTIF"
fi
