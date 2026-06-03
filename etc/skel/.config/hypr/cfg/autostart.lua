-- ▔▔▔▔▔▔▔▔▔▔▔▔▔▔ Startup Applications ▔▔▔▔▔▔▔▔▔▔▔▔▔▔
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    -- Noctalia Shell
    hl.exec_cmd("qs -c noctalia-shell")

    -- Clipboard history daemon: captures everything copied into cliphist's store.
    -- Requires wl-clipboard (already in CachyOS Hyprland ISO) and cliphist.
    hl.exec_cmd("wl-paste --type text  --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Night-light / blue-light filter.
    -- Uncomment and set your preferred colour temperature (in Kelvin).
    -- hl.exec_cmd("hyprsunset -t 4500")
end)
