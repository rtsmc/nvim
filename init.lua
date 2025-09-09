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
-- vim.keymap.set("n", "<C-e>", vim.cmd.Oil)
vim.keymap.set("n", "<C-e>", vim.cmd.Ex)
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>")
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", '<leader>qf', vim.diagnostic.setqflist);

local function small_term (cmd)
    vim.cmd.vnew()
    vim.cmd.term(cmd)
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
end

-- small terminal
vim.keymap.set("n", "<space>st", small_term)

-- racket language keybindings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rkt",
    callback = function()
        local escaped_filename = vim.fn.shellescape(vim.fn.expand('%:t'))
        vim.keymap.set("n", "<leader>r", function() small_term(escaped_filename) end)
    end
})

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
    { src = 'https://github.com/rebelot/kanagawa.nvim' },
    { src = 'https://github.com/nvim-mini/mini.pick' },
    { src = 'https://github.com/nvim-mini/mini.icons' },
    { src = 'https://github.com/neovim/nvim-lspconfig' }
})

vim.cmd.colorscheme "kanagawa"

require "mini.icons".setup()
require "mini.pick".setup()

vim.lsp.enable({ "lua_ls", "clangd", "basedpyright", "ruff", "racket_langserver" })

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = "hint",
                    reportUnusedImport = "hint",
                    reportUnusedClass = "hint",
                    reportUnusedFunction = "hint",
                    reportPrivateImportUsage = "none",
                    reportPrivateLocalImportUsage = "none",
                    reportMissingTypeStubs = "none",
                },
            },
        },
    }
})

vim.lsp.config("ruff", {
    settings = {
        lint = {
            enable = false
        }
    }
})
