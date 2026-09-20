return {
    'Chaitanyabsprip/fastaction.nvim',
    opts = {
        { pattern = "quickfix", order = 1, key = "j" },
        { pattern = "fix",      order = 2, key = "f" },
        dismiss_keys = { "<c-c>", "q", "<esc>" }
    },
}
