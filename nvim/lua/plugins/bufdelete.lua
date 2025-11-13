return {
	"famiu/bufdelete.nvim",
	config = function()
		vim.keymap.set("n", "<C-x>", ":Bdelete<cr>", { desc = "Delete buffer" })
	end,
}
