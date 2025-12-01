return function(wezterm, config)
	config.initial_cols = 120
	config.initial_rows = 28

	config.font_size = 14
	config.font = wezterm.font({ family = "AtkynsonMono Nerd Font" })
	config.color_scheme = "rose-pine-moon"
	config.window_decorations = "RESIZE"
	config.colors = { selection_bg = "rgba(144 213 255 10%)", selection_fg = "none" }

	config.enable_tab_bar = true
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.tab_max_width = 32
	return config
end
