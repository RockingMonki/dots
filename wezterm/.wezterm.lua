local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font({
	family = "JetBrains Mono",
	-- italic = true,
})
config.font_size = 15.0
config.color_scheme = "Classic Dark (base16)"
config.window_padding = {
	top = 0,
	bottom = 0,
	left = 0,
	right = 0,
}
config.window_background_opacity = 0.65
config.macos_window_background_blur = 20
-- disable tab bar
config.enable_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "q",
		mods = "CTRL|SHIFT",
		action = wezterm.action.QuitApplication,
	},
}

return config
