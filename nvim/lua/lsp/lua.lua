return {
	enabled = true,
	server_name = "lua_ls",
	tools = { "stylua" },
	setup = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},
}
