-- ━━━━━━━━━━━━━━━━━━━━ Keybindings ━━━━━━━━━━━━━━━━━━━━
-- https://wiki.hypr.land/Configuring/Basics/Binds/
-- https://docs.noctalia.dev/v4/getting-started/keybinds/

-- ━━━━━ Mouse binds for floating windows ━━━━━
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ━━━━━ Applications ━━━━━
hl.bind("SUPER + Return",
    hl.dsp.exec_cmd("ghostty"),
    { description = "Open Terminal: Ghostty" })

hl.bind("SUPER + CTRL + Return",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call launcher toggle"),
    { description = "Open App Launcher: Noctalia" })

hl.bind("SUPER + B",
    hl.dsp.exec_cmd("helium-browser"),
    { description = "Open Browser: Helium" })

hl.bind("SUPER + ALT + L",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call lockScreen lock"),
    { description = "Lock Screen: Noctalia" })

hl.bind("SUPER + SHIFT + Q",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call sessionMenu toggle"),
    { description = "Session Menu: Noctalia" })

-- Please choose your own file manager.
hl.bind("SUPER + E",
    hl.dsp.exec_cmd("nautilus"),
    { description = "File Manager: Nautilus" })

hl.bind("SUPER + V",
    hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"),
    { description = "Clipboard History: cliphist" })

-- ━━━━━ Media Controls ━━━━━
hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call volume increase"),
    { locked = true, repeating = true })

hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call volume decrease"),
    { locked = true, repeating = true })

hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call volume muteOutput"),
    { locked = true })

hl.bind("XF86AudioMicMute",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call volume muteInput"),
    { locked = true })

hl.bind("XF86AudioNext",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media next"),
    { locked = true })

hl.bind("XF86AudioPrev",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media previous"),
    { locked = true })

hl.bind("XF86AudioPlay",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media playPause"),
    { locked = true })

hl.bind("XF86AudioPause",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call media playPause"),
    { locked = true })

-- ━━━━━ Brightness Controls ━━━━━
hl.bind("XF86MonBrightnessUp",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call brightness increase"),
    { locked = true, repeating = true })

hl.bind("XF86MonBrightnessDown",
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call brightness decrease"),
    { locked = true, repeating = true })

-- ━━━━━ Window Focus ━━━━━
hl.bind("SUPER + Q", hl.dsp.window.close())

hl.bind("SUPER + Left",  hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + H",     hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + Right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + L",     hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + Up",    hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + K",     hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + Down",  hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + J",     hl.dsp.focus({ direction = "d" }))

-- ━━━━━ Window Movement ━━━━━
hl.bind("SUPER + CTRL + Left",  hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CTRL + H",     hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CTRL + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CTRL + L",     hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CTRL + Up",    hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CTRL + K",     hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CTRL + Down",  hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + CTRL + J",     hl.dsp.window.move({ direction = "d" }))

-- ━━━━━ Monitor Focus ━━━━━
hl.bind("SUPER + SHIFT + Left",  hl.dsp.focus({ monitor = "l" }))
hl.bind("SUPER + SHIFT + Right", hl.dsp.focus({ monitor = "r" }))
hl.bind("SUPER + SHIFT + Up",    hl.dsp.focus({ monitor = "u" }))
hl.bind("SUPER + SHIFT + Down",  hl.dsp.focus({ monitor = "d" }))

-- ━━━━━ Move Window to Monitor ━━━━━
hl.bind("SUPER + SHIFT + CTRL + Left",  hl.dsp.window.move({ monitor = "l", follow = true }))
hl.bind("SUPER + SHIFT + CTRL + Right", hl.dsp.window.move({ monitor = "r", follow = true }))
hl.bind("SUPER + SHIFT + CTRL + Up",    hl.dsp.window.move({ monitor = "u", follow = true }))
hl.bind("SUPER + SHIFT + CTRL + Down",  hl.dsp.window.move({ monitor = "d", follow = true }))

-- ━━━━━ Workspace Switching ━━━━━
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "-1" }))

hl.bind("SUPER + CTRL + mouse_down", hl.dsp.window.move({ workspace = "+1", follow = true }))
hl.bind("SUPER + CTRL + mouse_up",   hl.dsp.window.move({ workspace = "-1", follow = true }))

for i = 1, 9 do
    hl.bind("SUPER + "        .. i, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + CTRL + " .. i, hl.dsp.window.move({ workspace = i, follow = true }))
end

hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "previous" }))

-- ━━━━━ Layout Controls ━━━━━
-- Expand to full width (closest Hyprland equivalent: maximize toggle)
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Center floating window
hl.bind("SUPER + C", hl.dsp.window.center())

-- Resize active window (Niri: set-column-width / set-window-height ±10%)
hl.bind("SUPER + MINUS",       hl.dsp.window.resize({ x = -50, y = 0,   relative = true }), { repeating = true })
hl.bind("SUPER + EQUAL",       hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + MINUS", hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + EQUAL", hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })

-- ━━━━━ Window Modes ━━━━━
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("SUPER + W", hl.dsp.group.toggle()) -- tabbed/grouped display (Niri: toggle-column-tabbed-display)

-- ━━━━━ Screenshots ━━━━━
-- grimblast: https://github.com/hyprwm/contrib
hl.bind("CTRL + SHIFT + 1", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind("CTRL + SHIFT + 2", hl.dsp.exec_cmd("grimblast copy output"))
hl.bind("CTRL + SHIFT + 3", hl.dsp.exec_cmd("grimblast copy active"))

-- ━━━━━ Power / Exit ━━━━━
-- uwsm users: replace exit() with exec_cmd("loginctl terminate-user \"\"")
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())

hl.bind("SUPER + SHIFT + P", hl.dsp.dpms({ action = "disable" }))
