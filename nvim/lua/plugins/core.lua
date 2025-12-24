return {
	"NMAC427/guess-indent.nvim",
	{
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
		init = function()
			vim.api.nvim_create_autocmd("VimEnter", {
				desc = "Open neotree on enter",
				once = true,
				callback = function()
					vim.cmd("Neotree show")
				end,
			})
		end,
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
	},
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			delay = 0,
			icons = {
				mappings = vim.g.have_nerd_font,
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},
			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", function()
				builtin.find_files({ hidden = true })
			end, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.surround").setup()

			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
}
