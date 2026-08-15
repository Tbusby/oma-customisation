-- Hyprland Omarchy config overrides
-- Loaded from hyprland.lua via require("hypr.customisations")
-- Add all customisations here

local browser = "firefox"
local terminal = "foot"

-- My bindings
hl.unbind("SUPER + B")
o.bind("SUPER + B", "Browser", browser)
hl.unbind("SUPER + SHIFT + RETURN")
o.bind("SUPER + SHIFT + RETURN", "Browser", browser)
hl.unbind("SUPER + SHIFT + B")
o.bind("SUPER + SHIFT + B", "Browser", browser)
hl.unbind("SUPER + SHIFT + ALT + B")
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", browser .. " --private-window")
hl.unbind("SUPER + SHIFT + E")
o.bind("SUPER + SHIFT + E", "Email", "omarchy-launch-or-focus thunderbird")
hl.unbind("SUPER + SHIFT + ALT + M")
o.bind("SUPER + SHIFT + ALT + M", "Terminal", terminal .. " -o font_size=9 cliamp")

-- Make Nautilus a floating window and set a good default size
o.window({ class = "^(org%.gnome%.Nautilus)$" }, { float = true, persistent_size = true })
o.window({ tag = "floating-window" }, { size = { 1200, 900 } })

-- Make Thunderbird float
o.window({ class = "^(org%.mozilla%.Thunderbird)$" }, { float = true, persistent_size = true })

-- Set inputs
hl.config({
  input = {
    kb_layout = "gb",
    kb_options = "compose:caps",

    repeat_rate = 40,
    repeat_delay = 250,

    numlock_by_default = true,

    sensitivity = -0.5,

    touchpad = {
      clickfinger_behavior = true,
      scroll_factor = 0.4,
    },
  },
})

-- Set smaller gaps and rounding
hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 2,
  },
  decoration = {
    rounding = 8,
  },
})
