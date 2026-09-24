return {
	"echasnovski/mini.icons",
	opts = {},
	config = function(_, opts)
		if vim.g.have_nerd_font then
			local MiniIcons = require("mini.icons")
			MiniIcons.setup(opts)
			MiniIcons.mock_nvim_web_devicons()
		end
	end,
}
