return {
	"rebelot/kanagawa.nvim",
	opts = { theme = "wave" },
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd.colorscheme("kanagawa")
	end,
}
