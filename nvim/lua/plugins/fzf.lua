return {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    enabled = vim.fn.executable 'make' == 1,
}
