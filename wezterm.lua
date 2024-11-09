-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "rose-pine"

config.font_size = 12

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.5,
}

config.colors = {
  visual_bell = "#202020",
}

config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 150,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 150,
  target = "CursorColor",
}

config.audible_bell = "Disabled"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = "RESIZE"

-- and finally, return the configuration to wezterm
return config
