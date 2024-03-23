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
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        },
        fzy_native = {
            override_generic_sorter = true;
            override_file_sorter = true;
        }
    }
})
require("telescope").load_extension("ui-select")
require('telescope').load_extension('fzy_native')

local builtin = require("telescope.builtin")
vim.keymap.set('n', "<leader>ff", builtin.find_files, {})
vim.keymap.set('n', "<leader>fg", builtin.git_files, {})
