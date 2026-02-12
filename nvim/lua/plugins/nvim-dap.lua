return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	config = function()
		-- Basic DAP signs
		vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint" })
		vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DapStopped" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "🔶", texthl = "DapBreakpointCondition" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "DapBreakpointRejected" })
	end,
}
