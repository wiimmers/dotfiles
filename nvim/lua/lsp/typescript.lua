return {
	enabled = true,
	server_name = "ts_ls",
	tools = { "prettier" },
	setup = {
		root_dir = function(fname)
			local util = require("lspconfig.util")
			-- Look for monorepo indicators first
			local root = util.root_pattern("pnpm-workspace.yaml", "lerna.json", "nx.json")(fname)
				or util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
			return root
		end,
		single_file_support = false, -- Disable for structured projects
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
				preferences = {
					includePackageJsonAutoImports = "on",
					importModuleSpecifierPreference = "relative",
				},
				-- Critical for monorepo stability:
				tsserver = {
					maxTsServerMemory = 8192, -- Increase if you have RAM
					useSyntaxServer = "auto", -- Use lighter server when possible
				},
			},
			javascript = {
				preferences = {
					includePackageJsonAutoImports = "on",
					importModuleSpecifierPreference = "relative",
				},
			},
		},
		-- Additional handlers for better monorepo support
		handlers = {
			["textDocument/publishDiagnostics"] = function(...)
				local params = select(2, ...)
				-- Filter out excessive diagnostics that can cause slowdown
				if params and params.diagnostics then
					params.diagnostics = vim.tbl_filter(function(d)
						-- You can add filters here if needed
						return true
					end, params.diagnostics)
				end
				vim.lsp.diagnostic.on_publish_diagnostics(...)
			end,
		},
		flags = {
			debounce_text_changes = 150, -- Reduce LSP updates during typing
		},
	},
	on_attach = function(client, bufnr)
		-- Populate workspace diagnostics for TypeScript/JavaScript files
		require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
	end,
}
