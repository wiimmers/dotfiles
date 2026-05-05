return function(wezterm)
	local colors = require("plugins.colors")
	local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

	wezterm.on("update-right-status", function(window, pane)
		local dow = wezterm.strftime(" %a ") -- Day of week
		local month = wezterm.strftime(" %b ") -- Month abbreviation
		local day = wezterm.strftime("%d ") -- Day of month
		local time = wezterm.strftime(" %I:%M:%S ") -- Time in 24-hour format

		window:set_right_status(wezterm.format({
			{ Background = { Color = colors.tab_bar_background } },
			{ Foreground = { Color = colors.clock_dark } },
			{ Text = SOLID_LEFT_ARROW },
			{ Background = { Color = colors.clock_dark } },
			{ Foreground = { Color = colors.tab_bar_background } },
			{ Text = dow },
			{ Background = { Color = colors.clock_dark } },
			{ Foreground = { Color = colors.clock_med } },
			{ Text = SOLID_LEFT_ARROW },
			{ Background = { Color = colors.clock_med } },
			{ Foreground = { Color = colors.tab_bar_background } },
			{ Text = month },
			{ Text = day },
			{ Background = { Color = colors.clock_med } },
			{ Foreground = { Color = colors.clock_light } },
			{ Text = SOLID_LEFT_ARROW },
			{ Background = { Color = colors.clock_light } },
			{ Foreground = { Color = colors.white } },
			{ Text = time },
		}))
	end)
end
