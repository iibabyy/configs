return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		default_format_opts = {
			lsp_format = "fallback", -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
		},
		-- You can also specify external formatters in here.
		formatters_by_ft = {
			nu = { "nufmt" },
			just = { "just" },
		},

		formatters = {
			nufmt = {
				command = "nufmt",
				args = { "$FILENAME" },
				stdin = false
			},
			just = {
				prepend_args = { "--indentation", "\t" },
			},
		}
	},
	config = function(_, opts)
		require("conform").setup(opts)

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			require("conform").format({ async = true })
		end, { desc = "[F]ormat buffer" })
	end,
}
