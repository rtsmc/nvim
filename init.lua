----------------------------------------------------------------------------------
-- Vim Options
----------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.netrw_bufsettings = 'nu rnu'
vim.o.nu = true
vim.o.relativenumber = true
-- tab/indent related
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
-- other
vim.o.wrap = false
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.o.clipboard = "unnamedplus"
vim.o.winborder = "rounded"
vim.o.signcolumn = "yes"

-- built in terminal settings
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.o.number = false
        vim.o.relativenumber = false
    end,
})

----------------------------------------------------------------------------------
-- Keybinds
----------------------------------------------------------------------------------
vim.keymap.set("n", "<C-e>", vim.cmd.Oil)
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>")
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", '<leader>qf', vim.diagnostic.setqflist);

-- small terminal
vim.keymap.set("n", "<space>st",
    function()
        vim.cmd.vnew()
        vim.cmd.term()
        vim.cmd.wincmd("J")
        vim.api.nvim_win_set_height(0, 15)
    end)

-- formatting keybind
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set({ 'n', 'x' }, 'gq', function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

-- mini pick keybinds
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")


----------------------------------------------------------------------------------
-- Plugins
----------------------------------------------------------------------------------
vim.pack.add({
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/echasnovski/mini.pick" },
})

vim.cmd.colorscheme "kanagawa"

require "oil".setup()
require "mini.icons".setup()
require "mini.pick".setup()

vim.lsp.enable({ "lua_ls", "clangd", "basedpyright", "ruff"})
