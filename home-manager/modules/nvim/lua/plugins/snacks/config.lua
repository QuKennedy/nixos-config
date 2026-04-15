require("snacks").setup({
    explorer = {
        win = {
            sidebar = {
                width = 60,
            },
        },
    },
    picker = {
        sources = {
            explorer = {
                layout = {
                    layout = {
                        -- > 1 for absolute columns, 0 to 1 for percentage
                        width = 60,
                        min_width = 60,
                    },
                },
            },
        },
    },
    bigfile = {},
    image = {},
    lazygit = {},
    terminal = {},
    rename = {},
    notifier = {},
    indent = {},
    gitbrowse = {},
    scope = {},
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- 'enter = false' tells the picker to open but not "enter" the window
        require("snacks").explorer.open({ enter = false })
    end,
})
