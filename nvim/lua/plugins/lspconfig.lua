return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
		"artemave/workspace-diagnostics.nvim",
		"SmiteshP/nvim-navic",
	},
	config = function()
		-- Load shared LSP configuration
		require("config.lsp-config")

		-- Define which languages to enable (toggle from init.lua)
		local enabled_languages = LSP_LANGUAGES or {
			typescript = true,
			python = true,
			lua = true,
			terraform = true,
			rust = true,
		}

		-- Load language configurations
		local servers = {}
		local all_tools = {}

		for lang, enabled in pairs(enabled_languages) do
			if enabled then
				local ok, lang_config = pcall(require, "lsp." .. lang)
				if ok and lang_config.enabled then
					servers[lang_config.server_name] = lang_config.setup

					-- Collect tools for mason-tool-installer
					for _, tool in ipairs(lang_config.tools or {}) do
						table.insert(all_tools, tool)
					end

					-- Store on_attach for later use
					if lang_config.on_attach then
						servers[lang_config.server_name]._custom_on_attach = lang_config.on_attach
					end
				end
			end
		end

		-- Setup mason-tool-installer with all tools
		require("mason-tool-installer").setup({ ensure_installed = all_tools })

		-- Setup workspace-diagnostics for TypeScript
		require("workspace-diagnostics").setup({
			workspace_files = function()
				-- For TypeScript/JavaScript, find all relevant files
				-- Adjust patterns based on your monorepo structure
				return vim.fn.systemlist(
					"fd -e ts -e tsx -e js -e jsx -e mts -e cts -e mjs -e cjs . " .. vim.fn.getcwd()
				)
			end,
		})

		-- Add command to manually refresh workspace diagnostics
		vim.api.nvim_create_user_command("WorkspaceDiagnosticsRefresh", function()
			local clients = vim.lsp.get_clients()
			for _, client in ipairs(clients) do
				if client.name == "ts_ls" or client.name == "tsserver" then
					local bufnr = vim.api.nvim_get_current_buf()
					require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
					print("Refreshing workspace diagnostics for " .. client.name)
				end
			end
		end, { desc = "Refresh workspace diagnostics for all TypeScript projects" })

		-- Get capabilities from blink.cmp
		local capabilities = require("config.lsp-config").get_capabilities()

		-- Setup mason-lspconfig handlers
		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					local custom_on_attach = server._custom_on_attach
					server._custom_on_attach = nil -- Remove from setup table

					-- Merge custom on_attach with default if exists
					if custom_on_attach then
						local original_on_attach = server.on_attach
						server.on_attach = function(client, bufnr)
							if original_on_attach then
								original_on_attach(client, bufnr)
							end
							custom_on_attach(client, bufnr)
						end
					end

					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
