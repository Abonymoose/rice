#!/bin/bash
# rice install script - clone, symlink, install deps

set -e

echo "Installing rice..."

# Clone repo
if [ ! -d ~/.rice ]; then
  git clone https://github.com/Abonymoose/rice.git ~/.rice
fi

cd ~/.rice
git pull origin main

# Create symlinks
mkdir -p ~/.config ~/.local/share/applications
ln -sf ~/.rice/.config/i3 ~/.config/i3
ln -sf ~/.rice/.config/polybar ~/.config/polybar
ln -sf ~/.rice/.config/rofi ~/.config/rofi
ln -sf ~/.rice/.config/picom ~/.config/picom
ln -sf ~/.rice/.config/alacritty ~/.config/alacritty
ln -sf ~/.rice/.config/cava ~/.config/cava
ln -sf ~/.rice/.Xresources ~/.Xresources

# Install dependencies
sudo xbps-install -S i3 polybar rofi picom alacritty feh cava cmus lf firefox pulseaudio htop ncdu bluez bluez-alsa xorg-server xorg-input-libinput

echo "Rice installed! Start i3 with: startx"
