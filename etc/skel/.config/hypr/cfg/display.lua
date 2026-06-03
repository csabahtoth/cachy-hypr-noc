-- ▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪ Output Configuration ▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪
-- Run `hyprctl monitors all` to get the correct name for your displays.
-- https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Fallback rule: auto-place any monitor not explicitly configured
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- Uncomment and edit to configure a specific display:
-- hl.monitor({
--     output = "DP-1",
--     mode = "2560x1440@360",
--     position = "0x0",
--     scale = 1,
-- })
