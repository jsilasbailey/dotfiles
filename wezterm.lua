-- Pull in the wezterm API
local wezterm = require("wezterm") --[[@as Wezterm]]

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font_size = 12

config.color_scheme_dirs = {
  wezterm.home_dir .. "/.config/wezterm/color_schemes",
}
config.color_scheme = "Zenbones_dark"

config.inactive_pane_hsb = {
  hue = 1.0,
  saturation = 0.7,
  brightness = 0.5,
}

config.audible_bell = "Disabled"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

config.window_decorations = "RESIZE"

-- and finally, return the configuration to wezterm
return config
