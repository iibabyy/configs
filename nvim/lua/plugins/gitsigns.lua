return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "+" }, ---@diagnostic disable-line: missing-fields
			change = { text = "~" }, ---@diagnostic disable-line: missing-fields
			delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
			topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
			changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
			untracked = { text = "┆" }, ---@diagnostic disable-line: missing-fields
		},

		current_line_blame = true,
		current_line_blame_formatter = '<summary> • <author> • <author_time:%Y-%m-%d %H:%M>',
	},

	current_line_blame_opts = {
		delay = 250,
	},
}
