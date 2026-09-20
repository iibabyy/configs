return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        select = {
            backend = { "builtin" },
            builtin = {
                border = "rounded",
                relative = "cursor",
                mappings = {
                    ["l"] = "Confirm",
                },
            }
        }
    },
}
