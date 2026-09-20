return {
	"echasnovski/mini.icons",
	opts = {},
	config = function(_, opts)
		if vim.g.have_nerd_font then
			require("mini.icons").setup(opts)
			MiniIcons.mock_nvim_web_devicons()
		end
	end,
}
