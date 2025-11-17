-- Navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-;>", ":bprev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-'>", ":bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-q>", vim.cmd.quitall, { desc = "Quit all" })

-- LSP
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Debug
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<cr>", { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", ":DapContinue<cr>", { desc = "Continue" })
vim.keymap.set("n", "<leader>di", ":DapStepInto<cr>", { desc = "Step into" })
vim.keymap.set("n", "<leader>do", ":DapStepOut<cr>", { desc = "Step out" })
vim.keymap.set("n", "<leader>dr", ":DapStepOver<cr>", { desc = "Step over" })
vim.keymap.set("n", "<leader>dt", ":DapTerminate<cr>", { desc = "Terminate session" })

-- QOL
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "o", "o<Esc>", { desc = "Insert new line below without entering insert mode" })
vim.keymap.set("n", "O", "O<Esc>", { desc = "Insert new line above without entering insert mode" })

-- Splits
vim.keymap.set("n", "<leader>vv", "<C-w><C-v>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>cc", "<C-w><C-q>", { desc = "Close split" })
