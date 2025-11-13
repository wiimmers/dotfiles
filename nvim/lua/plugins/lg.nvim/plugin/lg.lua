if vim.g.loaded_lazygit_flyout then return end
vim.g.loaded_lazygit_flyout = true

if vim.fn.executable("lazygit") ~= 1 then
	vim.notify("lazygit not installed", vim.log.levels.ERROR)
	return
end

if not package.loaded["lg"] then
	vim.api.nvim_create_user_command("LazyGit", function()
		require("lg").toggle()
	end, { desc = "Toggle LazyGit" })
end
