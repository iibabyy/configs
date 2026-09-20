return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000, -- Make sure to load this before all the other start plugins
	config = function()
		-- Configure Catppuccin options if desired
		require("catppuccin").setup({
			flavour = "mocha",        -- Options: latte, frappe, macchiato, mocha (mocha is the dark one)
			transparent_background = false, -- Set to true if you want your terminal background to show through
			term_colors = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				telescope = true,
				treesitter = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = { background = true },
				},
			},
		})

		-- Setup the colorscheme
		vim.cmd.colorscheme("catppuccin")
	end,
}
