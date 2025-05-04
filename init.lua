-- map the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- vim.opts
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8

-- package manager
require("config.lazy")

-- <C-e> to exit editor
vim.keymap.set("n", "<C-e>", vim.cmd.Ex)

-- keybinds to move through quickfix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>")

-- better keybind for exiting terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- terminal settings
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

-- small terminal
vim.keymap.set("n", "<space>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
end)

-- terminal in new tab
vim.keymap.set("n", "<space>nt", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("T")
end)
