-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    --fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                          , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    --color theme
    use 'rmehri01/onenord.nvim'

    --treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    --lsp stuff
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    --completion engine
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'

    --specific java lsp because java
    use 'mfussenegger/nvim-jdtls'

    --snippet engine
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

end)
