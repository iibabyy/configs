return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require("tiny-inline-diagnostic").setup({
            -- Make diagnostic background transparent
            transparent_bg = true,

            options = {
                multilines = {
                    enabled = true,     -- Enable support for multiline diagnostic messages
                    always_show = true, -- Always show messages on all lines of multiline diagnostics
                },
            },
        })

        vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    end,
}
