return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/lg.nvim",
		config = function()
			local lg = require("lg")
			lg.setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
	},
}
