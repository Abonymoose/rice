#!/bin/sh
# Prints NOTIFY: <count of waiting notifications>, or NOTIFY: off when paused.
# Requires dunstctl. Plain text, no icon fonts.
if dunstctl is-paused 2>/dev/null | grep -q "true"; then
    echo "NOTIFY: off"
else
    count=$(dunstctl count waiting 2>/dev/null)
    echo "NOTIFY: ${count:-0}"
fi
