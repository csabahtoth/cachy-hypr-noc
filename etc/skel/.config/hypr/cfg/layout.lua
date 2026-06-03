-- ━━━━━━━━━━━━━━━━ Layout Configuration ━━━━━━━━━━━━━━━━
-- https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        -- 8+8=16px between tiled windows, 16px to screen edge — matches Niri gaps 16
        gaps_in  = 8,
        gaps_out = 16,

        layout = "dwindle",

        resize_on_border = true,
    },

    dwindle = {
        pseudotile     = false,
        preserve_split = true,
    },

    binds = {
        -- Niri: workspace-auto-back-and-forth
        -- Pressing the current workspace number again returns to the previous one.
        workspace_back_and_forth = true,
    },
})
