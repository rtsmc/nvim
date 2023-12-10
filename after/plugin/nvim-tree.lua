vim.keymap.set('n', "<leader>fl", vim.cmd.NvimTreeToggle)
vim.keymap.set('n', "<leader>lf", vim.cmd.NvimTreeFindFile)

require("nvim-tree").setup({
    hijack_netrw = true,
    view = {
        adaptive_size = true,
        float = {
            enable = false,
        },
    },
    actions = {
        open_file = {
            quit_on_open = false,
        }
    }
})
