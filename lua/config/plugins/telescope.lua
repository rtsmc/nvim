return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },

        config = function()
            require('telescope').load_extension('fzf')

            vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files)
            vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags)

            -- edit neovim config files
            vim.keymap.set("n", "<leader>en", function()
                require('telescope.builtin').find_files {
                    cwd = vim.fn.stdpath("config")
                }
            end)


            -- multigrep (for searching within files) stuff
            -- require "config.telescope.multigrep".setup()
            local pickers = require "telescope.pickers"
            local finders = require "telescope.finders"
            local make_entry = require "telescope.make_entry"
            local conf = require "telescope.config".values

            local live_multigrep = function(opts)
                opts = opts or {}
                opts.cwd = opts.cwd or vim.uv.cwd()

                local finder = finders.new_async_job {
                    command_generator = function(prompt)
                        if not prompt or prompt == "" then
                            return nil
                        end

                        local pieces = vim.split(prompt, "  ")
                        local args = { "rg" }
                        if pieces[1] then
                            table.insert(args, "-e")
                            table.insert(args, pieces[1])
                        end

                        if pieces[2] then
                            table.insert(args, "-g")
                            table.insert(args, pieces[2])
                        end

                        ---@diagnostic disable-next-line: deprecated
                        return vim.tbl_flatten {
                            args,
                            { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }
                        }
                    end,
                    entry_maker = make_entry.gen_from_vimgrep(opts),
                    cwd = opts.cwd,
                }

                pickers.new(opts, {
                    debounce = 50,
                    prompt_title = "Multi Grep",
                    finder = finder,
                    previewer = conf.grep_previewer(opts),
                    sorter = require("telescope.sorters").empty(),
                }):find()
            end

            vim.keymap.set("n", "<leader>fg", live_multigrep)
        end
    }
}
