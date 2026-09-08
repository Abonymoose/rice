# rice

A complete, cohesive dark grey/black i3 window manager rice for Void Linux.
i3 + polybar + rofi + picom + Alacritty, unified around one palette, one
corner radius system, one font, and one wallpaper (a dot-matrix rendering of
Michelangelo's *The Creation of Adam*).

## Features

- **i3**: Mod1 (Alt) modifier, WASD focus/movement, workspaces 1-5, split/
  layout controls, XF86 volume keys, small gaps (inner 8 / outer 0),
  autostarts xrdb, polybar, picom, and the wallpaper.
- **polybar**: dark bar, 28px tall, rounded corners (radius 8),
  semi-transparent (`#1a1a1a` @ 0.85 opacity), floating with an 8px margin.
  Modules: workspaces (left), clock (center), battery, volume, bluetooth,
  notifications (right) — all plain text, no icon fonts.
- **rofi**: `drun` app launcher only (no file/window/ssh modes), semi-
  transparent black background, `#2a2a2a` buttons/selection, rounded
  corners (radius 8), monospace font.
- **picom**: rounded window corners (radius 15), gaussian blur (strength 5),
  0.85 opacity everywhere (general windows, Alacritty, rofi), subtle
  shadows, tuned to avoid flicker (`use-damage`, `detect-rounded-corners`,
  no unredirect).
- **Alacritty**: black background, grey (`#cccccc`) text and cursor,
  monospace 12, 0.85 opacity — xterm/uxterm have been removed entirely.
- **wallpaper**: a dot-matrix, black & white rendering of *The Creation of
  Adam*.

## Keybindings (Mod1 = Alt)

| Binding | Action |
|---|---|
| `Alt+Return` | alacritty |
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
sudo xbps-install -S i3 polybar rofi picom alacritty feh curl pulseaudio
```

xterm/uxterm are not required by this rice — Alacritty is the only terminal
used.

## Installation

Clone this repo to `~/.config/rice` — the i3 config references the wallpaper
directly at `~/.config/rice/wallpaper/...`, so keep it there:

```
git clone https://github.com/Abonymoose/rice.git ~/.config/rice
```

Symlink the individual configs into place:

```
mkdir -p ~/.config
ln -sf ~/.config/rice/.config/i3        ~/.config/i3
ln -sf ~/.config/rice/.config/polybar   ~/.config/polybar
ln -sf ~/.config/rice/.config/rofi      ~/.config/rofi
ln -sf ~/.config/rice/.config/picom     ~/.config/picom
ln -sf ~/.config/rice/.config/alacritty ~/.config/alacritty
ln -sf ~/.config/rice/.Xresources       ~/.Xresources
chmod +x ~/.config/polybar/scripts/*.sh
```

Reload i3 (`Alt+Shift+c`) or restart it (`Alt+Shift+r`).

## Theme

One palette everywhere: `#000000` (black), `#cccccc` (grey text/accents),
and `#1a1a1a` / `#2a2a2a` (dark greys) as the *only* colors used across i3
borders, polybar, rofi, and Alacritty. One corner-radius system: 8px on the
polybar bar and rofi window, 15px on tiled windows via picom. One font:
monospace at 11-12px across polybar, rofi, and Alacritty. One spacing
system: 8px i3 gaps, 8px polybar bar offset/margin. One transparency
system: 0.85 opacity everywhere — Alacritty, general windows, and the
semi-transparent polybar/rofi backgrounds — all layered over the wallpaper
for a soft, premium, intentional look.
