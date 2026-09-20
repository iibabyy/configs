return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			providers = {
				"lsp",
				"treesitter",
				"regex",
			},
			delay = 100,
			filetypes_denylist = {
				"dirbuf",
				"dirvish",
				"fugitive",
				"NvimTree",
				"TelescopePrompt",
			},
		})
	end,
	keys = {
		{
			"]]",
			function()
				require("illuminate").goto_next_reference(false)
			end,
			desc = "Next Reference",
		},
		{
			"[[",
			function()
				require("illuminate").goto_prev_reference(false)
			end,
			desc = "Prev Reference",
		},
	},
}
