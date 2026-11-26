return {
	"basola21/PDFview",
	dependencies = { "nvim-telescope/telescope.nvim" },
	cmd = "PDFview",
	keys = {
		{ "<leader>sp", "<cmd>PDFview<CR>", desc = "[S]earch [P]DFs" },
	},
	init = function()
		if not vim.g.terminal_graphics then
			-- Open *.pdf files as extracted text instead of loading the binary
			vim.api.nvim_create_autocmd("BufReadCmd", {
				pattern = "*.pdf",
				callback = function(args)
					require("pdfview").open(vim.api.nvim_buf_get_name(args.buf))
					vim.schedule(function()
						if vim.api.nvim_buf_is_valid(args.buf) then
							vim.api.nvim_buf_delete(args.buf, { force = true })
						end
					end)
				end,
			})
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "pdfview",
			callback = function(args)
				local renderer = require("pdfview.renderer")
				vim.keymap.set("n", "]p", renderer.next_page, { buffer = args.buf, desc = "PDFview: Next page" })
				vim.keymap.set("n", "[p", renderer.previous_page, { buffer = args.buf, desc = "PDFview: Previous page" })
			end,
		})
	end,
}
