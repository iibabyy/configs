-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

require("options")
require("keymaps")
require("autocmds")

require("config.lazy")
