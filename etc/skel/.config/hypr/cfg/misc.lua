-- ━━━━━━━━━━━━━━━━ Miscellaneous ━━━━━━━━━━━━━━━━
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- ━━━━━ Wayland toolkit backends ━━━━━
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORM",                    "wayland;xcb")
-- gtk3: Qt apps follow the adw-gtk3-dark GTK theme set in dconf,
-- matching the original Niri config and keeping all apps visually consistent.
hl.env("QT_QPA_PLATFORMTHEME",               "gtk3")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- ━━━━━ XDG session ━━━━━
hl.env("XDG_CURRENT_DESKTOP",  "Hyprland")
hl.env("XDG_SESSION_TYPE",     "wayland")
hl.env("XDG_SESSION_DESKTOP",  "Hyprland")

-- ━━━━━ Cursor ━━━━━
hl.env("XCURSOR_THEME", "capitaine-cursors")
hl.env("XCURSOR_SIZE",  "24")

-- ━━━━━ Hyprland misc ━━━━━
hl.config({
    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,
        -- Niri: screenshot-path null — don't auto-save screenshots (grimblast copies to clipboard)
        -- Hyprland does not auto-save screenshots; this matches intent.
        -- Allows Noctalia notification actions to activate/raise windows.
        -- Closest equivalent to Niri's honor-xdg-activation-with-invalid-serial.
        focus_on_activate        = true,
    },
})
