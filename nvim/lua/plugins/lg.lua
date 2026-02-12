return {
	dir = vim.fn.stdpath("config") .. "/lua/plugins/lg.nvim",
	config = function()
		local lg = require("lg")
		lg.setup()
	end,
}
