-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false


-- ═══════════════════════════════════════════════════════════════════════════════
-- HJKL Vim-style navigation (keyboard has no arrow keys)
-- Unbind defaults that conflict, move them to SUPER + CTRL + <letter>
-- ═══════════════════════════════════════════════════════════════════════════════

-- ORIGINAL: SUPER + J was "Toggle window split"
hl.unbind("SUPER + J")
-- ORIGINAL: SUPER + K was "Keybindings menu"
hl.unbind("SUPER + K")
-- ORIGINAL: SUPER + L was "Toggle workspace layout"
hl.unbind("SUPER + L")

-- Remapped (CTRL + same letter preserves mnemonic)
o.bind("SUPER + CTRL + J", "Toggle window split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + CTRL + K", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + CTRL + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

-- Focus movement (HJKL)
o.bind("SUPER + H", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Focus up",   hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Focus right", hl.dsp.focus({ direction = "r" }))

-- Swap windows (SHIFT + HJKL)
o.bind("SUPER + SHIFT + H", "Swap left",  hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap down",  hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap up",    hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap right", hl.dsp.window.swap({ direction = "r" }))


-- ═══════════════════════════════════════════════════════════════════════════════
-- Flameshot (replaces default Omarchy screenshot on PRINT key)
-- ORIGINAL: PRINT was "Screenshot (omarchy-capture-screenshot)"
-- ═══════════════════════════════════════════════════════════════════════════════

hl.unbind("PRINT")
o.bind("PRINT", "Screenshot (Flameshot)", "flameshot screen -e -n $(hyprctl monitors -j | jq 'map(select(.focused == true)) | .[0].id')")