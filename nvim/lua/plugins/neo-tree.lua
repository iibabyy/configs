return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		init = function()
			-- Automatically load neo-tree if Neovim was opened with a directory argument (e.g. `nvim .`)
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
				once = true,
				callback = function()
					local argv = vim.fn.argv(0)
					if argv ~= "" and vim.fn.isdirectory(argv) == 1 then
						require("neo-tree")
					end
				end,
			})
		end,
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-Tree", silent = true },
		},
		opts = {
			window = {
				mappings = {
					-- Custom directional navigation
					["l"] = "open",
					["h"] = "close_node",

					-- Copy relative path
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							local relpath = vim.fn.fnamemodify(node:get_id(), ":.")
							vim.fn.setreg("+", relpath)
							vim.notify("Copied relative path: " .. relpath)
						end,
						desc = "Copy Relative Path",
					},
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(file_path)
						-- Closes Neo-Tree as soon as a file is selected
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
			filesystem = {
				window = {
					mappings = {
						["P"] = {
							"toggle_preview",
							config = {
								use_float = true, -- Open preview in a float (or false for a split)
								use_image_nvim = true, -- Enables image previews if image.nvim is installed
							},
						},
					},
				},
			},
		},

	},
}
