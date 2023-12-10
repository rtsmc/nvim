require("telescope").setup({
    defaults = {
        path_display = {
            shorten = {
                len = 3, exclude = {1, -1}
            },
            truncate = true
        },
        dynamic_preview_title = true,
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        }
    }
})
require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set('n', "<leader>ff", builtin.find_files, {})
vim.keymap.set('n', "<leader>fg", builtin.git_files, {})
