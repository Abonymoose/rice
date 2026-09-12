# rice

A minimal, unified dark grey/black desktop setup for **i3** on **Void Linux** —
i3, Alacritty, Polybar, Rofi, and Picom sharing one palette (`#000000` /
`#1a1a1a` / `#2a2a2a` / `#cccccc`), plus a small set of TUI tools bound
directly into i3.

## Features

- **i3** — Mod4 (Super) modifier, arrow-key navigation, 5 workspaces, 8px
  inner gaps, no i3bar (Polybar replaces it)
- **Alacritty** — borderless, semi-transparent (0.85 opacity) terminal
- **Polybar** — workspaces / clock / battery / volume, rounded corners,
  semi-transparent background
- **Rofi** — app launcher (`drun`) styled to match the rest of the rice,
  reused as the engine for the Bluetooth, volume, and power menus
- **Picom** — lightweight compositor: rounded corners only, no
  shadow/fade/blur, tuned for older/integrated GPUs
- **cava** — terminal audio visualizer, reads from the default PulseAudio
  sink's monitor (works with cmus or any other player)
- **cmus** — terminal music player, themed to match the rice palette
- **lf** — terminal file manager
- **Firefox** — web browsing, also handles image/video viewing
- **Power menu** — logout / restart / shutdown / suspend via Rofi
- **Bluetooth & volume menus** — scan/connect/disconnect/power and 0-100
  volume control via Rofi, also discoverable through your app launcher
- **htop**, **ncdu** — system monitor and disk usage, in Alacritty

## Keybinds

All bindings use `$mod` = **Mod4** (Super key) unless noted otherwise.

| Keybind | Action |
|---|---|
| `$mod+Return` | Open Alacritty |
| `$mod+space` | Rofi app launcher (`drun`) |
| `$mod+e` | Open lf (file manager) in Alacritty |
| `$mod+b` | Open Firefox |
| `$mod+n` | Open cmus (music player) in Alacritty |
| `$mod+a` | Open cava (audio visualizer) in Alacritty |
| `$mod+d` | Open ncdu (disk usage) in Alacritty |
| `Control+Shift+Escape` | Open htop (system monitor) in Alacritty |
| `$mod+Shift+b` | Bluetooth menu (scan/connect/disconnect/power) |
| `$mod+Shift+v` | Volume menu (set 0-100) |
| `$mod+w` | Kill focused window |
| `$mod+Left/Down/Up/Right` | Move focus |
| `$mod+Shift+Left/Down/Up/Right` | Move focused window |
| `$mod+1..5` | Switch to workspace 1-5 |
| `$mod+Shift+1..5` | Move focused container to workspace 1-5 |
| `$mod+h` | Split horizontal |
| `$mod+v` | Split vertical |
| `$mod+f` | Toggle fullscreen |
| `$mod+Shift+space` | Toggle floating |
| `$mod+Shift+c` | Reload i3 config |
| `$mod+Shift+r` | Restart i3 in place |
| `$mod+q` | Exit i3 (with confirmation prompt) |

There is no dedicated power-menu keybind yet — launch it directly with
`~/.config/rofi/scripts/power-menu.sh`, or through your app launcher.

## Installation

```sh
# 1. Clone the repo
git clone https://github.com/Abonymoose/rice.git ~/.rice

# 2. Back up any existing configs that would be overwritten
mkdir -p ~/.config-backup
for f in i3 alacritty polybar rofi picom cava; do
  [ -e ~/.config/"$f" ] && mv ~/.config/"$f" ~/.config-backup/
done

# 3. Symlink configs into place
mkdir -p ~/.config ~/.local/share/applications
ln -s ~/.rice/.config/i3          ~/.config/i3
ln -s ~/.rice/.config/alacritty   ~/.config/alacritty
ln -s ~/.rice/.config/polybar     ~/.config/polybar
ln -s ~/.rice/.config/rofi        ~/.config/rofi
ln -s ~/.rice/.config/picom       ~/.config/picom
ln -s ~/.rice/.config/cava        ~/.config/cava
ln -s ~/.rice/.local/share/applications/bluetooth-manager.desktop \
      ~/.local/share/applications/bluetooth-manager.desktop
ln -s ~/.rice/.local/share/applications/volume-manager.desktop \
      ~/.local/share/applications/volume-manager.desktop

# 4. Wallpaper
mkdir -p ~/.config/wallpaper
ln -s ~/.rice/wallpaper/creation-of-adam.png ~/.config/wallpaper/creation-of-adam.png

# 5. Make scripts executable
chmod +x ~/.rice/.config/rofi/scripts/*.sh

# 6. Install dependencies (see below), then start i3
```

## Dependencies

Install via `xbps-install` on Void Linux:

```sh
sudo xbps-install -S \
  i3 alacritty polybar rofi picom feh \
  cava cmus lf firefox \
  htop ncdu \
  pulseaudio bluez \
  xdotool i3-nagbar
```

| Package | Used for |
|---|---|
| `i3` | Window manager |
| `alacritty` | Terminal emulator |
| `polybar` | Status bar |
| `rofi` | App launcher, Bluetooth/volume/power menus |
| `picom` | Compositor (rounded corners) |
| `feh` | Wallpaper |
| `cava` | Audio visualizer |
| `cmus` | Music player |
| `lf` | File manager |
| `firefox` | Web browser / media viewer |
| `htop` | System monitor |
| `ncdu` | Disk usage analyzer |
| `pulseaudio` | Audio backend (`pactl`, used by the volume menu and cava) |
| `bluez` | Bluetooth backend (`bluetoothctl`, used by the Bluetooth menu) |

`i3-nagbar` ships with `i3` and is used for the exit confirmation prompt.

## Configuration files

```
.config/i3/config                          i3 window manager config
.config/alacritty/alacritty.toml           Terminal emulator config
.config/polybar/config.ini                 Status bar config
.config/rofi/config.rasi                   App launcher theme
.config/rofi/scripts/bluetooth-menu.sh     Bluetooth Rofi menu
.config/rofi/scripts/volume-menu.sh        Volume Rofi menu
.config/rofi/scripts/power-menu.sh         Power (logout/restart/shutdown/suspend) Rofi menu
.config/picom/picom.conf                   Compositor config
.config/cava/config                        Audio visualizer config
.local/share/applications/
  bluetooth-manager.desktop                Launcher entry for the Bluetooth menu
  volume-manager.desktop                   Launcher entry for the volume menu
wallpaper/creation-of-adam.png             Desktop wallpaper
```

## License

MIT — see below.

```
MIT License

Copyright (c) 2025 Abonymoose

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
