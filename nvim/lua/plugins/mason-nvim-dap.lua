return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
	config = function()
		require("mason-nvim-dap").setup({
			automatic_installation = true,
			handlers = {},
			ensure_installed = {
				"js-debug-adapter",
				"codelldb",
			},
		})
	end,
}
