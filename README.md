# rice - Void Linux i3 Setup

## Phase 1: Foundation

**Goal:** Unified aesthetic i3 setup with Alacritty, Rofi, Polybar, Picom.

### Config Specs

#### i3
- Mod1 (Alt) modifier
- WASD window movement (left/down/up/right)
- Alt+Return = Alacritty
- Alt+Space = Rofi
- Workspaces 1-5
- Gaps: inner 8, outer 0
- Autostart: xrdb, polybar, picom, wallpaper

#### Alacritty
- Background: #000000 (opacity 0.85)
- Text: #cccccc
- Cursor: #cccccc
- Font: monospace 12

#### Polybar
- Left: workspaces
- Center: time
- Right: battery, volume, bluetooth, notifications
- Colors: #000000, #cccccc, #1a1a1a, #2a2a2a
- Rounded corners (radius 8)
- Semi-transparent

#### Rofi
- Apps only
- B/W minimal theme
- Semi-transparent
- Rounded corners (radius 8)

#### Picom
- Blur: gaussian, strength 5
- Rounded corners: radius 15
- Opacity: 0.85
- Smooth fading

#### Wallpaper
- Creation of Adam (PNG)
- Path: ~/.config/wallpaper/creation-of-adam.png
