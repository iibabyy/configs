return {
	"sindrets/diffview.nvim",
	event = "VeryLazy",
	opts = {
		enhanced_diff_hl = true,
		use_icons = true,
	},
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "[G]it [D]iffview open" },
		{ "<leader>gc", "<cmd>DiffviewClose<CR>", desc = "[G]it [C]lose diffview" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "[G]it file [H]istory" },
		{ "<leader>gr", "<cmd>DiffviewRefresh<CR>", desc = "[G]it diffview [R]efresh" },
	},
}
