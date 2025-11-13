return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			-- Basic DAP signs
			vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DapStopped" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "🔶", texthl = "DapBreakpointCondition" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "DapBreakpointRejected" })
		end,
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				config = function()
					local dap, dapui = require("dap"), require("dapui")

					-- Setup dap-ui with custom layout
					dapui.setup({
						layouts = {
							{
								elements = {
									{ id = "scopes", size = 0.25 },
									"breakpoints",
									"stacks",
									"watches",
								},
								size = 50,
								position = "right",
							},
							{
								elements = {
									"console",
								},
								size = 0.25,
								position = "bottom",
							},
						},
					})

					-- Configure js-debug-adapter for Node.js/TypeScript debugging
					dap.adapters["pwa-node"] = {
						type = "server",
						host = "localhost",
						port = "${port}",
						executable = {
							command = "js-debug-adapter",
							args = { "${port}" },
						},
					}

					-- TypeScript/JavaScript configurations for monorepo
					for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
						dap.configurations[language] = {
							{
								type = "pwa-node",
								request = "launch",
								name = "Launch with pnpm",
								cwd = "${workspaceFolder}",
								runtimeExecutable = "pnpm",
								runtimeArgs = { "start" },
								console = "integratedTerminal",
								sourceMaps = true,
								killBehavior = "forceful",
								stopOnEntry = false,
								preLaunchTask = {
									type = "shell",
									command = "pnpm",
									args = { "tsc" },
									group = "build",
									presentation = {
										echo = true,
										reveal = "always",
										focus = false,
										panel = "shared",
									},
								},
							},
						}
					end

					-- Auto-open/close UI
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
			},
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = { "williamboman/mason.nvim" },
				config = function()
					require("mason-nvim-dap").setup({
						automatic_installation = true,
						handlers = {},
						ensure_installed = {
							"js-debug-adapter",
						},
					})
				end,
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("nvim-dap-virtual-text").setup({
						enabled = true,
						enabled_commands = true,
						highlight_changed_variables = true,
						highlight_new_as_changed = false,
						show_stop_reason = true,
						commented = false,
						virt_text_pos = "eol",
					})
				end,
			},
		},
	},
}
