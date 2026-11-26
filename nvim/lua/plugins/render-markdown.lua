return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.icons",
	},
	opts = {},
	keys = {
		{ "<leader>Mr", "<cmd>RenderMarkdown toggle<CR>", ft = "markdown", desc = "[M]arkdown [R]ender toggle" },
	},
}
