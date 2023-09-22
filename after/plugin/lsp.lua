-- keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(ev)
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  end
})

-- mason
require('mason').setup()

--mason-lspconfig
require('mason-lspconfig').setup({
    ensure_installed = {
        --put the language servers here, see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md# for server names
        'lua_ls',
        'eslint',
        'clangd',
        'tsserver',
    }
})

--completion engine
local cmp = require'cmp'
cmp.setup {
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip'    },
        { name = 'nvim_lsp_signature_help' },
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users. 
      end,
    },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

--setup lua server
require'lspconfig'.lua_ls.setup {
    capabilities = capabilities,
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    library = { vim.env.VIMRUNTIME }
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                    -- library = vim.api.nvim_get_runtime_file("", true)
                }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end
}

--setup other servers
require'lspconfig'.eslint.setup{capabilities = capabilities}
require'lspconfig'.clangd.setup{capabilities = capabilities}
require'lspconfig'.tsserver.setup{capabilities = capabilities}
require'lspconfig'.pylyzer.setup{capabilities = capabilities}
