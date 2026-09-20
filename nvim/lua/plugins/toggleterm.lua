return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15,
			open_mapping = [[<C-`>]], -- Binds Ctrl + ~ to the bottom horizontal terminal
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			direction = "horizontal",
			float_opts = {
				border = "curved",
			},
		})

		-- Custom mapping for Ctrl + t to toggle floating terminal
		local Terminal = require("toggleterm.terminal").Terminal
		local float_term = Terminal:new({
			direction = "float",
			hidden = true,
		})

		function _float_term_toggle()
			float_term:toggle()
		end

		vim.keymap.set(
			{ "n", "t", "i" },
			"<C-t>",
			"<cmd>lua _float_term_toggle()<CR>",
			{ noremap = true, silent = true, desc = "Toggle Floating Terminal" }
		)
	end,
}
