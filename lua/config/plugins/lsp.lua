return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            -- enable language servers
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('clangd')
            vim.lsp.enable('sourcekit')
            vim.lsp.enable('gopls')

            -- configure language servers
            vim.lsp.config('sourcekit', {
                filetypes = { "swift", "objc", "objcpp" }
            })

            -- shows error messages
            vim.diagnostic.config({ virtual_text = true })

            -- setup format keybinding with a function
            -- that runs when an LSP attaches to a buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    -- check if the client supports formatting, then bind
                    -- <leader>gq to format the file
                    if client.supports_method(client, 'textDocument/formatting') then
                        vim.keymap.set('n', '<leader>gq',
                            function() vim.lsp.buf.format({ bufnr = args.buf, id = client.id }) end)
                    end
                end,
            })
        end,
    }
}
