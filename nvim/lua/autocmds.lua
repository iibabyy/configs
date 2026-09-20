-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Change Neovim's cwd to the opened file's directory
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			return
		end

		-- Get the full path of the first argument
		local arg = vim.fn.argv(0)
		local path = vim.fn.fnamemodify(arg, ":p")

		-- Determine the directory (if it's a file, get its parent directory)
		local dir = vim.fn.isdirectory(path) == 1 and path or vim.fn.fnamemodify(path, ":h")

		-- Change the directory if it exists
		if vim.fn.isdirectory(dir) == 1 then
			vim.api.nvim_set_current_dir(dir)
		end
	end,
})

-- Style notifications
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })

local original_apply_workspace_edit = vim.lsp.util.apply_workspace_edit

---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.apply_workspace_edit = function(workspace_edit, offset_encoding)
	original_apply_workspace_edit(workspace_edit, offset_encoding)
	vim.schedule(function()
		vim.api.nvim_exec_autocmds("CursorMoved", { buffer = 0 })
	end)
end

-- Save when exiting a buffer
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "WinLeave" }, {
	pattern = "*",
	callback = function()
		if vim.bo.modified and vim.bo.buflisted and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! write")
		end
	end,
})
