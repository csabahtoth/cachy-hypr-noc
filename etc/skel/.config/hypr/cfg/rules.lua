-- ━━━━━━━━━━━━━━━━ Window & Layer Rules ━━━━━━━━━━━━━━━━
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- ━━━━━ Global decoration — rounded corners + blur + shadow ━━━━━
-- Matches Niri: geometry-corner-radius 20, clip-to-geometry true
hl.config({
    decoration = {
        rounding       = 20,
        rounding_power = 2,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled        = true,
            size           = 3,
            passes         = 2,
            vibrancy       = 0.1696,
            new_optimizations = true,
        },
    },
})

-- ━━━━━ Steam ━━━━━
-- Float all Steam windows except the main client
hl.window_rule({
    match = { class = "steam", title = "negative:^[Ss]team$" },
    float = true,
})

-- Steam notification toasts: float, no focus, bottom-right corner
hl.window_rule({
    match            = { class = "steam", title = "^notificationtoasts_[0-9]+_desktop$" },
    float            = true,
    no_initial_focus = true,
    move             = { "monitor_w-window_w-10", "monitor_h-window_h-10" },
})

-- ━━━━━ Noctalia layer rules ━━━━━
-- Wallpaper sits behind everything (Niri: place-within-backdrop true)
hl.layer_rule({
    match = { namespace = "^noctalia-wallpaper" },
    order = -999,
})

-- Bar, panels, and popups get blur (matches Noctalia Hyprland docs)
hl.layer_rule({
    match        = { namespace = "^noctalia-background-" },
    blur         = true,
    blur_popups  = true,
    ignore_alpha = 0.5,
})
