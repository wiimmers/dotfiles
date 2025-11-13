return function(wezterm)
	local colors = require("plugins.colors")
	local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
	local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local function tab_is_last()
			if tab.tab_index == #tabs - 1 then
				return true
			else
				return false
			end
		end

		local function tab_is_first()
			if tab.tab_index == 0 then
				return true
			else
				return false
			end
		end

		local function tab_is_only_tab()
			if tab_is_first() and tab_is_last() then
				return true
			else
				return false
			end
		end

		local function tab_is_left_n(n)
			for _, t in ipairs(tabs) do
				if t.is_active then
					local active_index = t.tab_index
					if tab.tab_index == active_index - n then
						return true
					else
						return false
					end
				end
			end
		end

		local function tab_is_left_one()
			return tab_is_left_n(1)
		end

		local function tab_is_left_two()
			return tab_is_left_n(2)
		end

		local function tab_is_right_n(n)
			for _, t in ipairs(tabs) do
				if t.is_active then
					local active_index = t.tab_index
					if tab.tab_index == active_index + n then
						return true
					else
						return false
					end
				end
			end
		end

		local function tab_is_right_one()
			return tab_is_right_n(1)
		end

		local function tab_is_right_two()
			return tab_is_right_n(2)
		end

		local title_text = wezterm.truncate_left(tab.active_pane.title, 18)

		if tab.is_active and not tab_is_last() and not tab_is_first() then
			return {
				{ Background = { Color = colors.iris_med } },
				{ Foreground = { Color = colors.iris_light } },
				{ Text = SOLID_LEFT_ARROW },
				{ Background = { Color = colors.iris_light } },
				{ Foreground = { Color = colors.tab_bar_background } },
				{ Text = " " .. title_text .. " " },
				{ Background = { Color = colors.iris_med } },
				{ Foreground = { Color = colors.iris_light } },
				{ Text = SOLID_RIGHT_ARROW },
			}
		elseif tab.is_active and not tab_is_last() and tab_is_first() then
			return {
				{ Background = { Color = colors.iris_light } },
				{ Foreground = { Color = colors.tab_bar_background } },
				{ Text = " " .. title_text .. " " },
				{ Background = { Color = colors.iris_med } },
				{ Foreground = { Color = colors.iris_light } },
				{ Text = SOLID_RIGHT_ARROW },
			}
		elseif tab.is_active and tab_is_only_tab() then
			return {
				{ Background = { Color = colors.iris_light } },
				{ Foreground = { Color = colors.tab_bar_background } },
				{ Text = " " .. title_text .. " " },
				{ Background = { Color = colors.tab_bar_background } },
				{ Foreground = { Color = colors.iris_light } },
				{ Text = SOLID_RIGHT_ARROW },
			}
		elseif tab_is_left_one() and not tab_is_first() then
			return {
				{ Background = { Color = colors.iris_dark } },
				{ Foreground = { Color = colors.iris_med } },
				{ Text = SOLID_LEFT_ARROW },
				{ Background = { Color = colors.iris_med } },
				{ Foreground = { Color = colors.tab_bar_background } },
				{ Text = " " .. tab.tab_index + 1 .. " " },
			}
		elseif tab_is_left_two() then
			return {
				{ Background = { Color = colors.tab_bar_background } },
				{ Foreground = { Color = colors.iris_dark } },
				{ Text = SOLID_LEFT_ARROW },
				{ Background = { Color = colors.iris_dark } },
				{ Foreground = { Color = colors.tab_bar_background } },
				{ Text = " " .. tab.tab_index + 1 .. " " },
			}
		elseif tab_is_right_one() and not tab_is_last() then
			return {
				{ Background = { Color = colors.iris_med } },
				{ Foreground = { Color = colors.tab_bar_background } },
				{ Text = " " .. tab.tab_index + 1 .. " " },
				{ Background = { Color = colors.iris_dark } },
				{ Foreground = { Color = colors.iris_med } },
				{ Text = SOLID_RIGHT_ARROW },
			}
		elseif tab_is_right_two() then
			return {
				{ Background = { Color = colors.iris_dark } },
				{ Foreground = { Color = colors.tab_bar_background } },
				{ Text = " " .. tab.tab_index + 1 .. " " },
				{ Background = { Color = colors.tab_bar_background } },
				{ Foreground = { Color = colors.iris_dark } },
				{ Text = SOLID_RIGHT_ARROW },
			}
		elseif tab.is_active and tab_is_last() then
			return {
				{ Background = { Color = colors.iris_med } },
				{ Foreground = { Color = colors.iris_light } },
				{ Text = SOLID_LEFT_ARROW },
				{ Background = { Color = colors.iris_light } },
				{ Foreground = { Color = colors.tab_bar_background } },
				{ Text = " " .. title_text .. " " },
				{ Background = { Color = colors.tab_bar_background } },
				{ Foreground = { Color = colors.iris_light } },
				{ Text = SOLID_RIGHT_ARROW },
			}
		elseif tab_is_right_one() and tab_is_last() then
			return {
				{ Background = { Color = colors.iris_med } },
				{ Foreground = { Color = colors.tab_bar_background } },
				{ Text = " " .. tab.tab_index + 1 .. " " },
				{ Background = { Color = colors.tab_bar_background } },
				{ Foreground = { Color = colors.iris_med } },
				{ Text = SOLID_RIGHT_ARROW },
			}
		elseif tab_is_first() and tab_is_left_one() then
			return {
				{ Background = { Color = colors.iris_med } },
				{ Foreground = { Color = colors.tab_bar_background } },
				{ Text = " " .. tab.tab_index + 1 .. " " },
			}
		else
			return {
				{ Background = { Color = colors.tab_bar_background } },
				{ Foreground = { Color = colors.iris_light } },
				{ Text = " " .. tab.tab_index + 1 .. " " },
			}
		end
	end)
end
