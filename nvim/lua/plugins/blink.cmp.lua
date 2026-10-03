return {
	"saghen/blink.cmp",
	dependencies = {
		"onsails/lspkind.nvim",
		"folke/lazydev.nvim",
	},
	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			accept = { auto_brackets = { enabled = true } },

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 250,
				treesitter_highlighting = true,
				window = { border = "rounded" },
			},

			list = {
				selection = {
					preselect = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
					auto_insert = function(ctx)
						return ctx.mode == "cmdline"
					end,
				},
			},

			menu = {
				border = "rounded",

				cmdline_position = function()
					if vim.g.ui_cmdline_pos ~= nil then
						local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
						return { pos[1] - 1, pos[2] }
					end
					local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
					return { vim.o.lines - height, 0 }
				end,
			},
		},

		keymap = {
			preset = "super-tab",
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },

			["<C-up>"] = { "scroll_documentation_up", "fallback" },
			["<C-down>"] = { "scroll_documentation_down", "fallback" },
		},

		signature = {
			enabled = true,
			window = { border = "rounded" },
		},

		sources = {
			default = { "lsp", "path", "buffer", "lazydev" },
			providers = {
				lsp = {
					score_offset = 99,
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				path = {
					-- min_keyword_length = 0,
					-- score_offset = 0
				},
				buffer = {
					max_items = 5,
					-- score_offset = -1
				},
			},
		},
	},
}
