return {
	"nvim-mini/mini.statusline",
	opts = {
		use_icons = vim.g.have_nerd_font,
	},
	config = function()
		require("mini.statusline").setup()
	end,
}
