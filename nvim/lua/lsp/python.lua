return {
	enabled = true,
	server_name = "pyright",
	tools = { "black", "isort" },
	setup = {
		settings = {
			python = {
				venvPath = vim.fn.expand("$VIRTUAL_ENV") or "",
				venv = vim.fn.fnamemodify(vim.fn.expand("$VIRTUAL_ENV/.."), ":t"),
				pythonPath = vim.fn.expand("$VIRTUAL_ENV/bin/python") or "python3.12",
				analysis = {
					typeCheckingMode = "basic",
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
				},
			},
		},
	},
}
