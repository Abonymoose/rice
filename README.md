# rice

A complete, minimal black & white i3 window manager rice for Void Linux.
i3 + polybar + rofi + picom + xterm, tied together with a single desaturated
wallpaper (Michelangelo's *The Creation of Adam*).

## Features

- **i3**: Mod1 (Alt) modifier, WASD focus/movement, 10 workspaces, small gaps
  (inner 8 / outer 0), autostarts xrdb, polybar, picom, and the wallpaper.
- **polybar**: minimal B/W bar, rounded corners (radius 8), floating with an
  8px margin. Modules: workspaces (left), clock (center), battery, volume,
  bluetooth, notifications (right) — no CPU/memory clutter.
- **rofi**: `drun` app launcher only (no file/window/ssh modes), minimal B/W
  theme, semi-transparent (`#000000cc`) background, rounded corners.
- **picom**: rounded window corners (radius 15), gaussian blur, and an
  opacity rule that makes xterm 85% opaque.
- **xterm**: white-on-black, minimal B/W 16-color palette, Terminus font.
- **wallpaper**: Michelangelo's *The Creation of Adam*, public domain,
  fetched on demand (see `wallpaper/README.md`) and meant to be desaturated
  to match the B/W theme.

## Install dependencies (Void Linux)

```
sudo xbps-install -S i3 polybar rofi picom xterm feh curl ImageMagick
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
ln -sf ~/.config/rice/.config/i3     ~/.config/i3
ln -sf ~/.config/rice/.config/polybar ~/.config/polybar
ln -sf ~/.config/rice/.config/rofi   ~/.config/rofi
ln -sf ~/.config/rice/.config/picom  ~/.config/picom
ln -sf ~/.config/rice/.Xresources    ~/.Xresources
chmod +x ~/.config/polybar/scripts/*.sh
```

Reload i3 (`Mod1+Shift+c`) or restart it (`Mod1+Shift+r`).

## Theme

Pure black & white throughout: `#000000` / `#ffffff` with `#cccccc` /
`#333333` / `#666666` as the only grays, semi-transparent surfaces (rofi,
xterm) over the desaturated wallpaper, and rounded corners on the bar,
windows, and rofi window for a soft, minimal look.
