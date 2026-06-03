#!/usr/bin/env bash
# CachyOS Hyprland → Noctalia Shell overlay installer
#
# Assumes a fresh CachyOS installation with the Hyprland desktop selected.
# Hyprland, PipeWire, NetworkManager, portals, grim, slurp, wl-clipboard, etc.
# are already present. This script installs Noctalia Shell, extra apps, themes,
# and drops the Hyprland Lua config into place.
#
# Run as a regular user with sudo privileges.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ━━━━━━━━━━━━━━━━ Helpers ━━━━━━━━━━━━━━━━

info()  { printf '\e[1;34m:: \e[0m%s\n' "$*"; }
ok()    { printf '\e[1;32m✓  \e[0m%s\n' "$*"; }
warn()  { printf '\e[1;33m!  \e[0m%s\n' "$*"; }
die()   { printf '\e[1;31m✗  \e[0m%s\n' "$*" >&2; exit 1; }

# ━━━━━━━━━━━━━━━━ Pre-flight checks ━━━━━━━━━━━━━━━━

[[ $EUID -eq 0 ]] && die "Do not run this script as root. Run as a regular user with sudo."
command -v pacman &>/dev/null || die "pacman not found. This script requires CachyOS / Arch Linux."

info "CachyOS Hyprland + Noctalia Shell — overlay installer"
echo

# Ensure the system is fully up to date before installing new packages.
# -Syu (not -Sy) avoids the Arch partial-upgrade hazard where a fresh DB sync
# pulls in package metadata that expects newer libraries than are installed.
info "Upgrading system packages first (pacman -Syu)..."
sudo pacman -Syu --noconfirm

# ━━━━━━━━━━━━━━━━ Packages to add ━━━━━━━━━━━━━━━━
#
# The CachyOS Hyprland ISO already provides:
#   hyprland, xdg-desktop-portal-hyprland, xdg-desktop-portal-gtk,
#   hyprlock, hypridle, hyprpaper, pipewire, wireplumber, networkmanager,
#   polkit, grim, slurp, wl-clipboard, rofi, and a default terminal/bar.
#
# We install only what is on top of that base.

PACKAGES=(
    # ── Noctalia Shell ───────────────────────────────────────────────
    # quickshell (qs) is the Noctalia runtime; available in CachyOS repo.
    noctalia-shell

    # ── Terminal (replacing the CachyOS default) ─────────────────────
    ghostty

    # ── Browser ──────────────────────────────────────────────────────
    # helium-browser-bin is an AUR package; the AUR fallback path handles it.
    helium-browser-bin

    # ── File manager ─────────────────────────────────────────────────
    nautilus

    # ── Screenshot wrapper ────────────────────────────────────────────
    # grimblast wraps grim+slurp for interactive/window/screen captures.
    grimblast

    # ── Clipboard history ─────────────────────────────────────────────
    # The watcher (wl-paste | cliphist store) is wired in autostart.lua.
    # SUPER+V opens the picker (rofi is assumed from the CachyOS ISO).
    cliphist

    # ── GTK dark theme ────────────────────────────────────────────────
    adw-gtk3

    # ── Cursor theme ──────────────────────────────────────────────────
    capitaine-cursors

    # ── Bluetooth GUI ─────────────────────────────────────────────────
    blueman

    # ── Night-light / blue-light filter ──────────────────────────────
    # Configure the temperature in cfg/autostart.lua (default: commented out).
    hyprsunset

    # ── Polkit agent ──────────────────────────────────────────────────
    # Enabled as a user service below; Noctalia's own plugin is also loaded.
    hyprpolkitagent

    # ── Fonts (emoji + CJK coverage) ─────────────────────────────────
    noto-fonts-emoji
    noto-fonts-cjk
    ttf-jetbrains-mono-nerd
)

# ━━━━━━━━━━━━━━━━ Install packages ━━━━━━━━━━━━━━━━

info "Installing packages (--needed skips already-installed ones)..."
MISSING=()
for pkg in "${PACKAGES[@]}"; do
    # Keep stderr visible so real failures (GPG errors, lock files, dependency
    # conflicts) are distinguishable from "package lives in AUR".
    if ! sudo pacman -S --noconfirm --needed "$pkg"; then
        MISSING+=("$pkg")
    fi
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
    warn "The following packages were not found in pacman/CachyOS repos:"
    for pkg in "${MISSING[@]}"; do
        echo "  - $pkg"
    done
    warn "If a package above failed for a reason other than 'not found' (e.g. GPG"
    warn "key, network error), fix that first before re-running."

    AUR_HELPER=""
    command -v yay  &>/dev/null && AUR_HELPER="yay"
    command -v paru &>/dev/null && AUR_HELPER="paru"

    if [[ -n "$AUR_HELPER" ]]; then
        info "Trying AUR via $AUR_HELPER for remaining packages..."
        "$AUR_HELPER" -S --noconfirm --needed "${MISSING[@]}" \
            || warn "Some AUR installs failed. Install them manually."
    else
        warn "No AUR helper (yay/paru) found. Install missing packages manually:"
        for pkg in "${MISSING[@]}"; do
            echo "    yay -S $pkg"
        done
    fi
fi

# ━━━━━━━━━━━━━━━━ Back up existing Hyprland config ━━━━━━━━━━━━━━━━

if [[ -d "$HOME/.config/hypr" ]]; then
    BACKUP="$HOME/.config/hypr.bak.$(date +%Y%m%d_%H%M%S)"
    info "Backing up existing ~/.config/hypr → $BACKUP"
    mv "$HOME/.config/hypr" "$BACKUP"
    ok "Backup created: $BACKUP"
fi

# ━━━━━━━━━━━━━━━━ Install Hyprland config ━━━━━━━━━━━━━━━━

info "Installing Hyprland configuration..."
mkdir -p "$HOME/.config/hypr/cfg"
cp -r "$SCRIPT_DIR/etc/skel/.config/hypr/"* "$HOME/.config/hypr/"
ok "Config installed at ~/.config/hypr/"

# ━━━━━━━━━━━━━━━━ Install Noctalia config ━━━━━━━━━━━━━━━━

info "Installing Noctalia plugin configuration..."
mkdir -p "$HOME/.config/noctalia"
cp "$SCRIPT_DIR/etc/skel/.config/noctalia/plugins.json" "$HOME/.config/noctalia/"
ok "Noctalia config installed at ~/.config/noctalia/"

# ━━━━━━━━━━━━━━━━ System-wide dconf settings ━━━━━━━━━━━━━━━━

info "Installing dconf profile (dark mode, GTK theme, cursor)..."
sudo install -Dm644 "$SCRIPT_DIR/etc/dconf/profile/user" \
    /etc/dconf/profile/user
sudo install -Dm644 "$SCRIPT_DIR/etc/dconf/db/local.d/00-cachyos.conf" \
    /etc/dconf/db/local.d/00-cachyos.conf
sudo dconf update
ok "dconf settings applied"

# ━━━━━━━━━━━━━━━━ User services ━━━━━━━━━━━━━━━━

# Polkit agent: must run as a user service so GUI elevation dialogs work
# (Nautilus mounts, Blueman pairing, NetworkManager, etc.).
info "Enabling hyprpolkitagent user service..."
systemctl --user enable --now hyprpolkitagent \
    && ok "hyprpolkitagent enabled" \
    || warn "hyprpolkitagent service failed to start — check: systemctl --user status hyprpolkitagent"

# ━━━━━━━━━━━━━━━━ System services ━━━━━━━━━━━━━━━━

info "Ensuring Bluetooth service is active..."
if ! systemctl is-enabled --quiet bluetooth 2>/dev/null; then
    sudo systemctl enable --now bluetooth \
        && ok "Bluetooth enabled" \
        || warn "Could not enable bluetooth service."
else
    ok "Bluetooth already enabled."
fi

# ━━━━━━━━━━━━━━━━ Done ━━━━━━━━━━━━━━━━

echo
ok "Done! Log out and log back in to start Hyprland with Noctalia Shell."
echo
echo "  Keybind cheatsheet:"
echo "    SUPER+Return          — Ghostty terminal"
echo "    SUPER+CTRL+Return     — Noctalia app launcher"
echo "    SUPER+B               — Helium browser"
echo "    SUPER+E               — Nautilus file manager"
echo "    SUPER+V               — Clipboard history (cliphist + rofi)"
echo "    SUPER+SHIFT+Q         — Session menu (logout / shutdown)"
echo "    SUPER+ALT+L           — Lock screen"
echo "    CTRL+SHIFT+1/2/3      — Screenshot (area / screen / window)"
echo "    SUPER+H/J/K/L         — Focus window (vi-style)"
echo "    SUPER+CTRL+H/J/K/L    — Move window"
echo "    SUPER+1–9             — Switch workspace"
echo "    SUPER+CTRL+1–9        — Move window to workspace"
echo
echo "  Night-light (hyprsunset): edit ~/.config/hypr/cfg/autostart.lua"
echo "  and uncomment the hyprsunset line with your preferred temperature."
echo
echo "  To configure a specific monitor, edit:"
echo "    ~/.config/hypr/cfg/display.lua"
echo "  Run 'hyprctl monitors all' to find your output names."
echo
