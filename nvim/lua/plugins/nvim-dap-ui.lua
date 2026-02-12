return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
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

		-- Configure codelldb for Rust debugging
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.rust = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

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
}
