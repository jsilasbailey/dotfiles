-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"

config.font_size = 12

config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.5,
}

-- and finally, return the configuration to wezterm
return config
