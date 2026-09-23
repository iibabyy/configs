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

				map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
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

		-- Read and load oad lsp config files in lua/lsp_servers/
		local lsp_config_path = vim.fn.stdpath("config") .. "/lua/lsp_servers"
		local files = vim.fn.glob(lsp_config_path .. "/*.lua", true, true)

		for _, file in ipairs(files) do
			local file_without_ext = vim.fn.fnamemodify(file, ":t:r")
			local lsp_config = require("lsp_servers." .. file_without_ext)
			local server_name = lsp_config.name or lsp_config[1]
			vim.lsp.config(server_name, lsp_config.opts)
			vim.lsp.enable(server_name)
		end

		-- Start rust_analyzer if a Cargo.toml is found
		vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
			desc = "Eagerly start rust_analyzer if Cargo.toml is found in the directory tree",
			group = vim.api.nvim_create_augroup("eager_rust_analyzer", { clear = true }),
			callback = function()
				-- vim.fs.root safely searches upwards, so it works even if you open Neovim in a subdirectory like src/
				local root = vim.fs.root(vim.uv.cwd(), "Cargo.toml")
				local cfg = vim.lsp.config.rust_analyzer

				if root and cfg then
					vim.lsp.start(vim.tbl_extend("force", {}, cfg, { root_dir = root }))
				end
			end,
		})
	end,
}
