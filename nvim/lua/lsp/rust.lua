return {
	enabled = true,
	server_name = "rust_analyzer",
	tools = { "codelldb" }, -- rust-analyzer is installed via rustup
	setup = {
		settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true,
				},
				diagnostics = {
					enable = true,
					experimental = {
						enable = true,
					},
				},
				checkOnSave = {
					command = "clippy",
				},
				inlayHints = {
					bindingModeHints = {
						enable = true,
					},
					chainingHints = {
						enable = true,
					},
					closingBraceHints = {
						enable = true,
						minLines = 25,
					},
					closureReturnTypeHints = {
						enable = "always",
					},
					discriminantHints = {
						enable = "always",
					},
					lifetimeElisionHints = {
						enable = "skip_trivial",
						useParameterNames = true,
					},
					parameterHints = {
						enable = true,
					},
					typeHints = {
						enable = true,
					},
				},
			},
		},
	},
}
