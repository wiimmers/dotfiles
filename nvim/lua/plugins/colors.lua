return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			disable_background = false,
			disable_italics = false,
			variant = "moon",
		})
		vim.cmd.colorscheme("rose-pine")
		local colors = require("rose-pine.palette")
		vim.api.nvim_set_hl(0, "Visual", { bg = colors.highlight_high, fg = "NONE" })
	end,
}
