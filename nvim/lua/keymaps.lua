-- [[ Basic Keymaps ]] See `:help vim.keymap.set()`
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, { desc = "LSP signature help" })

vim.keymap.set('n', '<CR>', 'o<ESC>', { desc = "Insert new line below" })
vim.keymap.set('n', '<S-CR>', 'O<ESC>', { desc = "Insert new line above" })

vim.keymap.set({ 'n', 'x' }, '<leader>ca', '<cmd>lua require("fastaction").code_action()<CR>',
    { desc = "[C]ode [A]ction" })
vim.keymap.set({ 'n', 'x' }, '<C-c>', '<cmd>lua require("fastaction").code_action()<CR>', { desc = "[C]ode action" })

vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<cmd>w<cr>")

vim.keymap.set({ 'n', 'v' }, 'H', 'b', { desc = 'Move to start of word' })
vim.keymap.set({ 'n', 'v' }, 'L', 'e', { desc = 'Move to end of word' })

-- Swap p and P in visual mode
vim.keymap.set("x", "p", "P")
vim.keymap.set("x", "P", "p")

vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('v', '<C-a>', '<Esc>ggVG', { desc = 'Select all' })
