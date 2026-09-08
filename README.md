# rice

A complete, cohesive black & white i3 window manager rice for Void Linux.
i3 + polybar + rofi + picom + xterm, unified around one palette, one corner
radius system, one font, and one wallpaper (Michelangelo's *The Creation of
Adam*).

## Features

- **i3**: Mod1 (Alt) modifier, WASD focus/movement, workspaces 1-5, split/
  layout controls, XF86 volume keys, small gaps (inner 8 / outer 0),
  autostarts xrdb, polybar, picom, and the wallpaper.
- **polybar**: minimal B/W bar, 28px tall, rounded corners (radius 8),
  semi-transparent, floating with an 8px margin. Modules: workspaces (left),
  clock (center), battery, volume, bluetooth, notifications (right) — no
  CPU/memory clutter.
- **rofi**: `drun` app launcher only (no file/window/ssh modes), minimal B/W
  theme, semi-transparent (`#000000cc`) background, rounded corners
  (radius 8), monospace font.
- **picom**: rounded window corners (radius 15), gaussian blur (strength 5),
  0.9 general opacity / 0.85 xterm opacity, subtle shadows, tuned to avoid
  flicker (`use-damage`, `detect-rounded-corners`, no unredirect).
- **xterm**: white background / black text, minimal B/W 16-color palette,
  monospace 11, blinking cursor.
- **wallpaper**: Michelangelo's *The Creation of Adam*, public domain,
  fetched on demand (see `wallpaper/README.md`) and meant to be desaturated
  to match the theme.

## Keybindings (Mod1 = Alt)

| Binding | Action |
|---|---|
| `Alt+Return` | xterm |
| `Alt+Space` | rofi |
| `Alt+W/A/S/D` | focus up/left/down/right |
| `Alt+Shift+W/A/S/D` | move window up/left/down/right |
| `Alt+1..5` | switch to workspace 1-5 |
| `Alt+Shift+1..5` | move window to workspace 1-5 |
| `Alt+H` / `Alt+V` | split horizontal / vertical |
| `Alt+E` | cycle layout: default (tiling) → stacked (full-height) → tabbed |
| `Alt+F` | fullscreen toggle |
| `Alt+Shift+Space` | floating toggle |
| `Alt+Shift+Q` | kill window |
| `Alt+Shift+C` | reload |
| `Alt+Shift+R` | restart |
| `Alt+Shift+E` | exit (with confirmation) |
| `XF86AudioRaiseVolume` / `LowerVolume` / `Mute` | volume up/down/mute |

## Install dependencies (Void Linux)

```
sudo xbps-install -S i3 polybar rofi picom xterm feh curl pulseaudio ImageMagick
```

## Installation

Clone this repo to `~/.config/rice` — the i3 config references the wallpaper
directly at `~/.config/rice/wallpaper/...`, so keep it there:

```
git clone https://github.com/Abonymoose/rice.git ~/.config/rice
```

Fetch and desaturate the wallpaper:

```
sh ~/.config/rice/wallpaper/download.sh
convert ~/.config/rice/wallpaper/creation-of-adam.jpg -colorspace Gray \
    ~/.config/rice/wallpaper/creation-of-adam.jpg
```

Symlink the individual configs into place:

```
mkdir -p ~/.config
ln -sf ~/.config/rice/.config/i3      ~/.config/i3
ln -sf ~/.config/rice/.config/polybar ~/.config/polybar
ln -sf ~/.config/rice/.config/rofi    ~/.config/rofi
ln -sf ~/.config/rice/.config/picom   ~/.config/picom
ln -sf ~/.config/rice/.Xresources     ~/.Xresources
chmod +x ~/.config/polybar/scripts/*.sh
```

Reload i3 (`Alt+Shift+c`) or restart it (`Alt+Shift+r`).

## Theme

One palette everywhere: `#000000` / `#ffffff` with `#cccccc` (accent) and
`#333333` / `#666666` (secondary grays) as the *only* colors used across i3
borders, polybar, rofi, and xterm. One corner-radius system: 8px on the
polybar bar and rofi window, 15px on tiled windows via picom. One font:
monospace at 11px across polybar, rofi, and xterm. One spacing system: 8px
i3 gaps, 8px polybar bar offset/margin. One transparency system: 0.85 on
xterm, 0.9 general window opacity, semi-transparent polybar and rofi
backgrounds — all layered over the desaturated wallpaper for a soft,
premium, intentional look.
