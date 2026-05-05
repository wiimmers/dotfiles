return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup()

		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		local last_real_buf = nil
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("statusline-track-real-buf", { clear = true }),
			callback = function(ev)
				if vim.bo[ev.buf].filetype ~= "neo-tree" and vim.bo[ev.buf].buftype == "" then
					last_real_buf = ev.buf
				end
			end,
		})

		local function statusline_buf()
			local buf = vim.api.nvim_get_current_buf()
			if vim.bo[buf].filetype == "neo-tree" and last_real_buf and vim.api.nvim_buf_is_valid(last_real_buf) then
				return last_real_buf
			end
			return buf
		end

		statusline.section_location = function()
			return "%2l:%-2v"
		end

		statusline.section_filename = function()
			local buf = statusline_buf()
			if vim.bo[buf].buftype == "terminal" then
				return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
			end

			local path = vim.api.nvim_buf_get_name(buf)
			if path == "" then
				return "[No Name]"
			end

			local cwd = vim.fn.getcwd()
			if path:sub(1, #cwd + 1) == cwd .. "/" then
				path = path:sub(#cwd + 2)
			else
				path = vim.fn.fnamemodify(path, ":~")
			end

			if vim.bo[buf].modified then
				path = path .. " [+]"
			end
			if vim.bo[buf].readonly then
				path = path .. " [RO]"
			end

			local ok, navic = pcall(require, "nvim-navic")
			if ok and navic.is_available(buf) then
				local loc = navic.get_location(nil, buf)
				if loc and loc ~= "" then
					path = path .. " › " .. loc
				end
			end

			return path
		end
	end,
}
