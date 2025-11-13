local wezterm = require("wezterm")
require("plugins.tab_title")(wezterm)
require("plugins.tab_time")(wezterm)

local config = wezterm.config_builder()
local wez_config = require("plugins.config")(wezterm, config)

return wez_config
