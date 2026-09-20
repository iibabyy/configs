return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
        -- Disable entire built-in ftplugin mappings to avoid conflicts.
        vim.g.no_plugin_maps = true
    end,
    config = function()
        require("nvim-treesitter-textobjects").setup({
            select = {
                -- Automatically jump forward to a textobj (similar to targets.vim)
                lookahead = true,

                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V",  -- linewise
                    ["@class.outer"] = "<c-v>", -- blockwise
                },
            },
            move = {
                set_jumps = true,
            },
        })

        -- Select Mappings
        local select = require("nvim-treesitter-textobjects.select")

        -- Map 'af' and 'if' to outer/inner function
        vim.keymap.set({ "x", "o" }, "af", function()
            select.select_textobject("@function.outer", "textobjects")
        end, { desc = "Around function" })
        vim.keymap.set({ "x", "o" }, "if", function()
            select.select_textobject("@function.inner", "textobjects")
        end, { desc = "Inside function" })

        -- Map 'ac' and 'ic' to outer/inner class
        vim.keymap.set({ "x", "o" }, "ac", function()
            select.select_textobject("@class.outer", "textobjects")
        end, { desc = "Around class/struct" })
        vim.keymap.set({ "x", "o" }, "ic", function()
            select.select_textobject("@class.inner", "textobjects")
        end, { desc = "Inside class/struct" })

        -- Map 'al' and 'il' to outer/inner function call
        vim.keymap.set({ "x", "o" }, "al", function()
            select.select_textobject("@call.outer", "textobjects")
        end, { desc = "Around function call" })
        vim.keymap.set({ "x", "o" }, "il", function()
            select.select_textobject("@call.inner", "textobjects")
        end, { desc = "Inside function call" })


        -- Move Mappings
        local move = require("nvim-treesitter-textobjects.move")

        vim.keymap.set({ "n", "x", "o" }, "]f", function()
            move.goto_next_start("@function.outer", "textobjects")
        end, { desc = "Next function start" })

        vim.keymap.set({ "n", "x", "o" }, "]F", function()
            move.goto_next_end("@function.outer", "textobjects")
        end, { desc = "Next function end" })

        vim.keymap.set({ "n", "x", "o" }, "[f", function()
            move.goto_previous_start("@function.outer", "textobjects")
        end, { desc = "Previous function start" })

        vim.keymap.set({ "n", "x", "o" }, "[F", function()
            move.goto_previous_end("@function.outer", "textobjects")
        end, { desc = "Previous function end" })

        -- Make Moves Repeatable with ; and ,
        local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

        -- Repeat jump with ; (forward) and , (backward)
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

        -- Ensure built-in f, F, t, T also integrate with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
