return {
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	version = "*",
	-- 	dependencies = "nvim-tree/nvim-web-devicons",
	-- 	config = function()
	-- 		local bufferline = require("bufferline")
	-- 		bufferline.setup({
	-- 			options = {
	-- 				hover = {
	-- 					enabled = true,
	-- 					delay = 200,
	-- 					reveal = { "close" },
	-- 				},
	-- 				offsets = {
	-- 					{
	-- 						filetype = "neo-tree",
	-- 						text = "  ",
	-- 						text_align = "left",
	-- 						separator = true,
	-- 					},
	-- 				},
	-- 				show_buffer_close_icons = false,
	-- 				show_buffer_icons = false,
	-- 				indicator = {
	-- 					style = "none",
	-- 				},
	-- 				highlights = {
	-- 					background = {
	-- 						"#292835",
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 		vim.keymap.set("n", "<C-;>", ":bprev<cr>", { desc = "Previous buffer" })
	-- 		vim.keymap.set("n", "<C-'>", ":bnext<cr>", { desc = "Next buffer" })
	-- 		vim.keymap.set("n", "<C-x>", ":bdelete<cr>", { desc = "Delete buffer" })
	-- 	end,
	-- },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"dockerfile",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"python",
				"typescript",
				"javascript",
				"json",
				"yaml",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
	},

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
}
