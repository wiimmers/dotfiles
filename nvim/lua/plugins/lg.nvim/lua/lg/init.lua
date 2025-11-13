local M = {}

M.state = { win = nil, buf = nil, term_chan = nil }

M.config = {
	width = 40,
	position = "right",
	lazygit_config = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":h:h:h") .. "/lazygit-config.yml",
}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
	vim.api.nvim_create_user_command("LazyGit", M.toggle, {})
	vim.keymap.set("n", "<leader>lg", M.toggle, { desc = "Toggle LazyGit" })
end

function M.is_open()
	return M.state.win and vim.api.nvim_win_is_valid(M.state.win)
end

function M.open()
	if M.is_open() then
		return
	end

	if not M.state.buf or not vim.api.nvim_buf_is_valid(M.state.buf) then
		M.state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[M.state.buf].filetype = "lazygit"
		vim.bo[M.state.buf].bufhidden = "hide"
	end

	local width = M.config.width
	local height = vim.o.lines - vim.o.cmdheight - 2
	local col = M.config.position == "right" and (vim.o.columns - width) or 0

	M.state.win = vim.api.nvim_open_win(M.state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = 0,
		style = "minimal",
		border = "rounded",
	})

	vim.wo[M.state.win].number = false
	vim.wo[M.state.win].relativenumber = false
	vim.wo[M.state.win].signcolumn = "no"

	-- Terminal mode keymaps for navigation while lazygit is active
	local opts = { buffer = M.state.buf, silent = true }
	vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
	vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
	vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
	vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
	vim.keymap.set("t", "<Esc>", M.close, opts)

	if not M.state.term_chan then
		local cmd = "lazygit --use-config-file=" .. M.config.lazygit_config
		M.state.term_chan = vim.fn.termopen(cmd, {
			on_exit = function()
				M.state.term_chan = nil
				vim.schedule(M.close)
			end,
		})
		vim.cmd.startinsert()
	else
		vim.cmd.startinsert()
	end
end

function M.close()
	if M.is_open() then
		vim.api.nvim_win_close(M.state.win, true)
		M.state.win = nil
	end
end

function M.toggle()
	if M.is_open() then
		M.close()
	else
		M.open()
	end
end

return M
