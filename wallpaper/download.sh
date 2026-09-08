#!/bin/sh
# Downloads Michelangelo's "The Creation of Adam" (public domain) as the rice wallpaper.
set -e
mkdir -p "$(dirname "$0")"
curl -L -o "$(dirname "$0")/creation-of-adam.jpg" \
    "https://commons.wikimedia.org/wiki/Special:FilePath/The_Creation_of_Adam_by_Michelangelo.JPG"
echo "Saved to $(dirname "$0")/creation-of-adam.jpg"
