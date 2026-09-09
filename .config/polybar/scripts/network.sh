#!/bin/sh
# Prints NET connected/disconnected. Interface-agnostic: checks for a
# default route rather than hardcoding a device name.
if ip route show default 2>/dev/null | grep -q default; then
    echo "NET connected"
else
    echo "NET disconnected"
fi
