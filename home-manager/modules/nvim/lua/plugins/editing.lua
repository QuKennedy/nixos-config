require("lze").load({
    {
        "blink.cmp",
        enabled = nixCats("general") or false,
        event = "DeferredUIEnter",
        on_require = "blink",
        after = function(plugin)
            require("blink.cmp").setup({
                -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
                -- See :h blink-cmp-config-keymap for configuring keymaps
                keymap = { preset = "default" },
                appearance = {
                    nerd_font_variant = "mono",
                },
                signature = { enabled = true },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
            })
        end,
    },
    {
        "nvim-treesitter",
        enabled = nixCats("general") or false,
        event = "DeferredUIEnter",
        load = function(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("nvim-treesitter-textobjects")
        end,
        after = function(plugin)
            -- [[ Configure Treesitter ]]
            -- See `:help nvim-treesitter`
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                indent = { enable = false },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<c-space>",
                        node_incremental = "<c-space>",
                        scope_incremental = "<c-s>",
                        node_decremental = "<M-space>",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                },
            })
        end,
    },
    {
        "mini.nvim",
        enabled = nixCats("general") or false,
        event = "DeferredUIEnter",
        after = function(plugin)
            require("mini.pairs").setup()
            require("mini.icons").setup()
            require("mini.ai").setup()
        end,
    },
})
