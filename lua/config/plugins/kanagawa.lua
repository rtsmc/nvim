return {
    {
        'rebelot/kanagawa.nvim',
        config = function()
            -- config
            require('kanagawa').setup({
                compile = true,
                terminalColors = true,

                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false, -- do not set background color
                dimInactive = false, -- dim inactive window `:h hl-NormalNC`
                colors = {           -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function() -- add/modify highlights
                    return {}
                end,
                theme = "wave",    -- Load "wave" theme
                background = {     -- map the value of 'background' option to a theme
                    dark = "wave", -- try "dragon" !
                    light = "lotus"
                },
            })

            -- set the nvim colorscheme
            vim.cmd.colorscheme "kanagawa"
        end
    }
}
