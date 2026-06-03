# cachy-hypr-noc

A [Hyprland](https://hyprland.org) + [Noctalia Shell](https://noctalia.dev) configuration for [CachyOS](https://cachyos.org), ported from [cachyos-niri-noctalia](https://github.com/cachyos/cachyos-niri-noctalia).

Targets a **fresh CachyOS installation with the Hyprland desktop already selected** — the script installs only the Noctalia overlay and supporting apps on top of what the ISO already provides. Hyprland's new Lua configuration format (v0.55+) is used throughout.

---

## Requirements

- CachyOS installed with the **Hyprland** desktop option
- Internet connection
- `yay` (ships with CachyOS by default) — needed for the `helium-browser-bin` AUR package

---

## Installation

Boot into CachyOS Hyprland, open a terminal, then:

```bash
git clone https://github.com/csabahtoth/cachy-hypr-noc.git
cd cachy-hypr-noc
bash install.sh
```

Log out and back in when it finishes.

### What the installer does

1. Runs `pacman -Syu` to ensure the system is fully up to date
2. Installs the packages listed below (skips anything already present)
3. Backs up your existing `~/.config/hypr` → `~/.config/hypr.bak.<timestamp>`
4. Installs the Hyprland Lua config to `~/.config/hypr/`
5. Installs the Noctalia plugin config to `~/.config/noctalia/`
6. Installs system-wide dconf settings (dark mode, GTK theme, cursor)
7. Enables `hyprpolkitagent` as a user service
8. Ensures the Bluetooth service is active

### Packages installed

| Package | Purpose |
|---|---|
| `noctalia-shell` | Desktop shell (bar, launcher, panels, lock screen) |
| `ghostty` | Terminal emulator |
| `helium-browser-bin` | Browser (AUR) |
| `nautilus` | File manager |
| `grimblast` | Screenshot wrapper (area / screen / window) |
| `cliphist` | Clipboard history |
| `adw-gtk3` | GTK dark theme (`adw-gtk3-dark`) |
| `capitaine-cursors` | Cursor theme |
| `blueman` | Bluetooth GUI |
| `hyprsunset` | Night-light / blue-light filter |
| `hyprpolkitagent` | Polkit agent for GUI elevation dialogs |
| `noto-fonts-emoji` `noto-fonts-cjk` `ttf-jetbrains-mono-nerd` | Fonts |

---

## Keybinds

All keybinds use the **Super** key (Windows key) as the primary modifier.

### Applications

| Bind | Action |
|---|---|
| `Super + Return` | Ghostty terminal |
| `Super + Ctrl + Return` | Noctalia app launcher |
| `Super + B` | Helium browser |
| `Super + E` | Nautilus file manager |
| `Super + V` | Clipboard history picker |
| `Super + Alt + L` | Lock screen |
| `Super + Shift + Q` | Session menu (logout / shutdown / reboot) |

### Windows

| Bind | Action |
|---|---|
| `Super + Q` | Close window |
| `Super + H/J/K/L` or `Super + ←↓↑→` | Focus window (vi-style) |
| `Super + Ctrl + H/J/K/L` or `Super + Ctrl + ←↓↑→` | Move window |
| `Super + T` | Toggle floating |
| `Super + F` | Toggle fullscreen |
| `Super + W` | Toggle tabbed group |
| `Super + C` | Centre floating window |
| `Super + Ctrl + F` | Maximise window |
| `Super + - / =` | Resize width −/+ 50px |
| `Super + Shift + - / =` | Resize height −/+ 50px |

### Workspaces

| Bind | Action |
|---|---|
| `Super + 1–9` | Switch to workspace |
| `Super + Ctrl + 1–9` | Move window to workspace |
| `Super + Tab` | Previous workspace |
| `Super + ScrollDown/Up` | Next / previous workspace |
| `Super + Ctrl + ScrollDown/Up` | Move window to next / previous workspace |

### Monitors

| Bind | Action |
|---|---|
| `Super + Shift + ←↓↑→` | Focus monitor in direction |
| `Super + Shift + Ctrl + ←↓↑→` | Move window to monitor in direction |

### Media & system

| Bind | Action |
|---|---|
| `XF86AudioRaiseVolume / LowerVolume` | Volume up / down |
| `XF86AudioMute` | Mute output |
| `XF86AudioMicMute` | Mute microphone |
| `XF86AudioPlay / Pause / Next / Prev` | Media playback |
| `XF86MonBrightnessUp / Down` | Screen brightness |
| `Ctrl + Shift + 1` | Screenshot — select area |
| `Ctrl + Shift + 2` | Screenshot — full screen |
| `Ctrl + Shift + 3` | Screenshot — active window |
| `Super + Shift + P` | Turn off monitors |
| `Ctrl + Alt + Delete` | Quit Hyprland |

---

## Configuration

Config lives in `~/.config/hypr/` and is split across focused files:

```
~/.config/hypr/
├── hyprland.lua          ← entry point, require()s everything below
└── cfg/
    ├── animation.lua     ← spring + bezier curves, animation tree
    ├── autostart.lua     ← noctalia-shell, cliphist daemons
    ├── display.lua       ← monitor setup (edit this for your displays)
    ├── input.lua         ← keyboard (gb layout), touchpad, mouse
    ├── keybinds.lua      ← all keybinds
    ├── layout.lua        ← gaps, dwindle layout, workspace back-and-forth
    ├── misc.lua          ← environment variables, cursor, XDG session
    └── rules.lua         ← rounding, blur, shadow, Steam + Noctalia rules
```

### Configuring your monitor

Run `hyprctl monitors all` to find your output names, then edit `~/.config/hypr/cfg/display.lua` and uncomment the example block.

### Night-light

Edit `~/.config/hypr/cfg/autostart.lua` and uncomment:
```lua
hl.exec_cmd("hyprsunset -t 4500")  -- adjust temperature in Kelvin
```

### Keyboard layout

`cfg/input.lua` defaults to `gb`. Change `kb_layout` to any valid XKB layout code.

---

## System-wide settings (dconf)

Applied to `/etc/dconf/db/local.d/00-cachyos.conf`:

| Setting | Value |
|---|---|
| Colour scheme | `prefer-dark` |
| GTK theme | `adw-gtk3-dark` |
| Cursor theme | `capitaine-cursors` |

---

## Credits

Based on [cachyos/cachyos-niri-noctalia](https://github.com/cachyos/cachyos-niri-noctalia) by the CachyOS team.  
Uses [Noctalia Shell](https://github.com/noctalia-dev/noctalia-shell) by the Noctalia developers.
