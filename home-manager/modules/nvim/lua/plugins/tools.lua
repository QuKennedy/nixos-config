require("lze").load({
    {
        "nvim-lint",
        enabled = nixCats("general") or false,
        event = "FileType",
        after = function(plugin)
            require("lint").linters_by_ft = {
                -- NOTE: download some linters in lspsAndRuntimeDeps
                -- and configure them here
                -- markdown = {'vale',},
                -- javascript = { 'eslint' },
                -- typescript = { 'eslint' },
                python = { "ruff" },
                go = nixCats("go") and { "golangcilint" } or nil,
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    {
        "conform.nvim",
        enabled = nixCats("general") or false,
        keys = {
            { "<leader>FF", desc = "[F]ormat [F]ile" },
        },
        after = function(plugin)
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    -- NOTE: download some formatters in lspsAndRuntimeDeps
                    -- and configure them here
                    -- python = { "ruff_format" },
                    python = { "ruff" },
                    lua = nixCats("lua") and { "stylua" } or nil,
                    go = nixCats("go") and { "gofmt", "golint" } or nil,
                    -- templ = { "templ" },
                    -- Conform will run multiple formatters sequentially
                    -- python = { "isort", "black" },
                    -- Use a sub-list to run only the first available formatter
                    -- javascript = { { "prettierd", "prettier" } },
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>FF", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end, { desc = "[F]ormat [F]ile" })
        end,
    },
    {
        "nvim-dap",
        enabled = nixCats("general") or false,
        keys = {
            { "<F5>", desc = "Debug: Start/Continue" },
            { "<F1>", desc = "Debug: Step Into" },
            { "<F2>", desc = "Debug: Step Over" },
            { "<F3>", desc = "Debug: Step Out" },
            { "<leader>b", desc = "Debug: Toggle Breakpoint" },
            { "<leader>B", desc = "Debug: Set Breakpoint" },
            { "<F7>", desc = "Debug: See last session result." },
        },
        load = function(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("nvim-dap-ui")
            vim.cmd.packadd("nvim-dap-virtual-text")
        end,
        after = function(plugin)
            local dap = require("dap")
            local dapui = require("dapui")

            -- Basic debugging keymaps, feel free to change to your liking!
            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set Breakpoint" })

            -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
            vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            -- Dap UI setup
            -- For more information, see |:help nvim-dap-ui|
            dapui.setup({
                -- Set icons to characters that are more likely to work in every terminal.
                --    Feel free to remove or use ones that you like more! :)
                --    Don't feel like these are good choices.
                icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
                controls = {
                    icons = {
                        pause = "⏸",
                        play = "▶",
                        step_into = "⏎",
                        step_over = "⏭",
                        step_out = "⏮",
                        step_back = "b",
                        run_last = "▶▶",
                        terminate = "⏹",
                        disconnect = "⏏",
                    },
                },
            })

            require("nvim-dap-virtual-text").setup({
                enabled = true,
                enabled_commands = true,
                highlight_changed_variables = true,
                highlight_new_as_changed = false,
                show_stop_reason = true,
                commented = false,
                only_first_definition = true,
                all_references = false,
                clear_on_continue = false,
                display_callback = function(variable, buf, stackframe, node, options)
                    if options.virt_text_pos == "inline" then
                        return " = " .. variable.value
                    else
                        return variable.name .. " = " .. variable.value
                    end
                end,
                virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
                all_frames = false,
                virt_lines = false,
                virt_text_win_col = nil,
            })

            -- NOTE: Install lang specific config
            -- either in here, or in a separate plugin spec as demonstrated for go below.
        end,
    },
    {
        "nvim-dap-go",
        enabled = nixCats("go") or false,
        on_plugin = { "nvim-dap" },
        after = function(plugin)
            require("dap-go").setup()
        end,
    },
    {
        -- lazydev makes your lsp way better in your config without needing extra lsp configuration.
        "lazydev.nvim",
        enabled = nixCats("lua") or false,
        cmd = { "LazyDev" },
        ft = "lua",
        after = function(_)
            require("lazydev").setup({
                library = {
                    { words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. "/lua" },
                },
            })
        end,
    },
})
