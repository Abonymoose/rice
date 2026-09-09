#!/bin/sh
# Prints NOT <count of waiting notifications>, or NOT off when paused.
# Requires dunstctl.
if dunstctl is-paused 2>/dev/null | grep -q "true"; then
    echo "NOT off"
else
    count=$(dunstctl count waiting 2>/dev/null)
    echo "NOT ${count:-0}"
fi
