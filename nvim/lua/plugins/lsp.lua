return {
	"williamboman/mason-lspconfig.nvim",
	event = "VimEnter",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- Runs when a lsp attach to a buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach-autocmd", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
				-- map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
				-- map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

				-- Toggle inlay hints
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method("textDocument/inlayHint", event.buf) then
					map("<leader>ih", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "Toggle [I]nlay [H]ints")
				end
			end,
		})

		-- Setup Mason

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"rust_analyzer",
				-- "harper_ls",
				"typos_lsp",
				"just",
			},
			automatic_installation = true,
		})

		-- Load lsp config files in lua/lsp_servers/
		local lsp_config_path = vim.fn.stdpath("config") .. "/lua/lsp_servers"
		local files = vim.fn.glob(lsp_config_path .. "/*.lua", true, true)

		for _, file in ipairs(files) do
			local modname = "lsp_servers." .. vim.fn.fnamemodify(file, ":t:r")
			local ret = require(modname)
			local server_name = ret[1]
			local opts = ret.opts
			vim.lsp.config(server_name, opts)
			vim.lsp.enable(server_name)
		end

		local cwd = vim.fn.getcwd()
		if vim.uv.fs_stat(vim.fs.joinpath(cwd, "Cargo.toml")) then
			local cfg = vim.lsp.config["rust_analyzer"]
			if cfg then
				vim.lsp.start(vim.tbl_extend("force", {}, cfg, {
					root_dir = cwd,
				}), {
					reuse_client = function(client, conf)
						return client.name == conf.name and client.config.root_dir == conf.root_dir
					end,
				})
			end
		end
	end,
}
