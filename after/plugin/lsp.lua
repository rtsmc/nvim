-- keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(ev)
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set('n', "<leader>nr", vim.lsp.buf.rename, opts)
      vim.keymap.set('n', "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', "K", vim.lsp.buf.hover, opts)
  end
})

--luasnip thing
require("luasnip.loaders.from_vscode").lazy_load()

--mason
require("mason").setup()

--mason-lspconfig
require("mason-lspconfig").setup({
    ensure_installed = {
        --put the language servers here, see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md# for server names
        "lua_ls",
        "eslint",
        "clangd",
        "rust_analyzer",
        "tsserver",
        "gopls",
        "html",
    }
})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require'cmp'

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
                -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = 'luasnip' },
        { name = 'path' },
    }, {
        { name = "buffer" },
    }),
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
})


-- Set up lspconfig.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig")["lua_ls"].setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                    '${3rd}/luv/library',
                    unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
            },
            completion = {
                callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
        },
    },
}

require("lspconfig")["clangd"].setup {
    capabilities = capabilities
}

require("lspconfig")["eslint"].setup {
    capabilities = capabilities
}

require("lspconfig")["rust_analyzer"].setup {
    capabilities = capabilities
}

require("lspconfig")["tsserver"].setup {
    capabilities = capabilities
}

require("lspconfig")["gopls"].setup {
    capabilities = capabilities
}

require("lspconfig")["html"].setup {
    capabilities = capabilities
}
