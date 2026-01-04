local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font({
	family = "JetBrains Mono",
	harfbuzz_features = {
		"calt=1", -- Contextual alternatives
		"clig=1", -- Contextual ligatures
		"liga=1", -- Standard ligatures
		"zero", -- Slashed zero
		"ss01", -- Stylistic set (varies by font)
	},
	weight = "Regular",
	-- italic = true,
})

config.color_scheme = "Dracula (base16)"

config.font_size = 14.5
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.enable_tab_bar = false

return config
