return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>rr", "<cmd>Neotree right<cr>", desc = "Neotree right" },
		{ "<leader>rl", "<cmd>Neotree left<cr>", desc = "Neotree left" },
		{ "<leader>rc", "<cmd>Neotree close<cr>", desc = "Neotree close" },
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				width = 30,
			},
			default_component_configs = {
				name = {
					use_git_status_colors = true,
				},
				diagnostics = {
					symbols = {
						hint = "󰌶",
						info = "󰋽",
						warn = "󰀪",
						error = "󰅚",
					},
					highlights = {
						hint = "DiagnosticSignHint",
						info = "DiagnosticSignInfo",
						warn = "DiagnosticSignWarn",
						error = "DiagnosticSignError",
					},
				},
			},
			filesystem = {
				components = {
					name = function(config, node, state)
						local cc = require("neo-tree.sources.common.components")
						local result = cc.name(config, node, state)

						-- Add diagnostic counts for directories and files
						if node.type == "directory" or node.type == "file" then
							local diag_count = node.extra and node.extra.diagnostics_count or {}
							local errors = diag_count.errors or 0
							local warnings = diag_count.warnings or 0

							if errors > 0 or warnings > 0 then
								local diag_text = ""
								if errors > 0 then
									diag_text = diag_text .. " 󰅚" .. errors
								end
								if warnings > 0 then
									diag_text = diag_text .. " 󰀪" .. warnings
								end
								table.insert(result, {
									text = diag_text,
									highlight = errors > 0 and "DiagnosticError" or "DiagnosticWarn",
								})
							end
						end

						return result
					end,
				},
			},
		})
	end,
}
