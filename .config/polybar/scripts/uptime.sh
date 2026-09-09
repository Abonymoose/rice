#!/bin/sh
# Prints UPT <days>d <hours>h based on /proc/uptime.
secs=$(cut -d. -f1 /proc/uptime)
days=$((secs / 86400))
hours=$(((secs % 86400) / 3600))
echo "UPT ${days}d ${hours}h"
