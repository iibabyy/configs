return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		image = {
			enabled = vim.g.terminal_graphics,
			resolve = function(_, src)
				if not src:find("^https?://") then
					return
				end
				-- GitHub "blob" links return an HTML page; point them at the raw file instead
				local repo, path = src:match("^https://github%.com/([^/]+/[^/]+)/blob/(.+)$")
				if repo then
					src = "https://raw.githubusercontent.com/" .. repo .. "/" .. path:gsub("%?raw=true$", "")
				end
				-- snacks url-decodes src before resolving, and curl rejects URLs containing spaces
				return (src:gsub(" ", "%%20"))
			end,
			doc = { enabled = true, inline = true, float = true, max_width = 80, max_height = 40 },
			formats = {
				"png",
				"jpg",
				"jpeg",
				"gif",
				"bmp",
				"webp",
				"tiff",
				"heic",
				"avif",
				"mp4",
				"mov",
				"avi",
				"mkv",
				"webm",
				"icns",
			},
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)
		if not vim.g.terminal_graphics then
			return
		end
		-- zellij >= 0.45 implements the kitty graphics protocol, but snacks still flags it as unsupported
		-- Unicode placeholders (inline images) come from zellij PR #5878, built locally
		for _, env in ipairs(require("snacks.image.terminal").envs()) do
			if env.name == "zellij" then
				env.supported = true
				env.placeholders = true
			end
		end
	end,
}
