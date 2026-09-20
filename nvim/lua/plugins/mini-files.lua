return {
    'nvim-mini/mini.files',
    enabled = false,

    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    version = false,
    config = function()
        require('mini.files').setup({
            mappings = {
                go_in = 'L',
                go_in_plus = 'l',
            }
        })

        -- toggle keymap
        local toggle_mini_files = function()
            if MiniFiles.close() then
                return
            end
            MiniFiles.open(vim.api.nvim_buf_get_name(0))
            MiniFiles.reveal_cwd()
        end
        vim.keymap.set({ "n", "v" }, "<leader>e", toggle_mini_files, { desc = "Toggle file [E]xplorer", silent = true })

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesActionOpen",
            callback = function(event)
                -- Ensures it closes only when a file target is selected
                if event.data.fs_entry.fs_type == "file" then
                    MiniFiles.close()
                end
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local buf_id = args.data.buf_id

                -- esc close the window
                vim.keymap.set("n", "<Esc>", function()
                    MiniFiles.close()
                end, { buffer = buf_id, desc = "Close mini.files" })

                -- saving the file sync the changes
                vim.bo[buf_id].buftype = "acwrite"
                vim.api.nvim_create_autocmd("BufWriteCmd", {
                    buffer = buf_id,
                    callback = function()
                        MiniFiles.synchronize()
                    end,
                })
            end,
        })
    end,
}
