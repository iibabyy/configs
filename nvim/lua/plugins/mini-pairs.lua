return {
	'nvim-mini/mini.pairs',
	dependencies = { "nvim-mini/mini.keymap", version = false },
	version = "*",
	config = function()
		require("mini.pairs").setup({
			mappings = {
				["("] = { neigh_pattern = "[^\\][%s>)%]},:]" },
				["["] = { neigh_pattern = "[^\\][%s>)%]},:]" },
				["{"] = { neigh_pattern = "[^\\][%s>)%]},:]" },
				['"'] = { neigh_pattern = "[%s<(%[{][%s>)%]},:]" },
				["'"] = { neigh_pattern = "[%s<(%[{][%s>)%]},:]" },
				["`"] = { neigh_pattern = "[%s<(%[{][%s>)%]},:]" },
				["<"] = { action = "open", pair = "<>", neigh_pattern = "[\r%w\"'`:].", register = { cr = false } },
				[">"] = { action = "close", pair = "<>", register = { cr = false } },
			},
		})

		require("mini.keymap").map_combo("i", "<", function()
			local line = vim.api.nvim_get_current_line()
			local col = vim.fn.col(".")
			-- stylua: ignore
			if line:sub(col - 2, col) == "<<>" then return "<Del>" end
		end)
		require("mini.keymap").map_combo("i", "=", function()
			local line = vim.api.nvim_get_current_line()
			local col = vim.fn.col(".")
			-- stylua: ignore
			if line:sub(col - 2, col) == "<=>" then return "<Del>" end
		end)
	end
}
