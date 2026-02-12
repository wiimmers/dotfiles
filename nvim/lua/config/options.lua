-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- [[ Setting options ]]
-- See `:help vim.o`
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.o.breakindent = true
vim.o.smartindent = false
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true

-- [[ LSP Configuration ]]
-- Limit file watching to prevent crashes in large monorepos
vim.opt.maxmempattern = 5000
-- Set LSP log level (change to "debug" if troubleshooting)
vim.lsp.set_log_level("warn")
