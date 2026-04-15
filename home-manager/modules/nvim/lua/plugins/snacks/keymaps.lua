vim.keymap.set("n", "-", function()
    Snacks.explorer.open()
end, { desc = "Snacks Explorer" })

-- Toggle bottom terminal
vim.keymap.set({ "n", "t" }, "<C-l>", function()
    Snacks.terminal.toggle(nil, { win = { position = "bottom", height = 0.3 } })
end, { desc = "Toggle terminal" })

-- Run current file in a bottom terminal
local function run_cmd(cmd)
    return string.format("bash -c '%s; echo; echo [exited]; read'", cmd)
end

local runners = {
    go = function()
        return run_cmd("go run " .. vim.fn.expand("%:p"))
    end,
    python = function()
        return run_cmd("python " .. vim.fn.expand("%:p"))
    end,
}
vim.keymap.set("n", "<leader>x", function()
    local runner = runners[vim.bo.filetype]
    if runner then
        Snacks.terminal.open(runner(), { win = { position = "bottom", height = 0.3 } })
    else
        vim.notify("No runner configured for filetype: " .. vim.bo.filetype, vim.log.levels.WARN)
    end
end, { desc = "Run file" })

-- TODO: make this keybind something maybe like leader t if that's not some easymotion
vim.keymap.set("n", "<c-\\>", function()
    Snacks.terminal.open()
end, { desc = "Snacks Terminal" })

vim.keymap.set("n", "<leader>_", function()
    Snacks.lazygit.open()
end, { desc = "Snacks LazyGit" })

-- Find
vim.keymap.set("n", "<leader>sf", function()
    Snacks.picker.smart()
end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader><leader>s", function()
    Snacks.picker.buffers()
end, { desc = "Search Buffers" })
vim.keymap.set("n", "<leader>ff", function()
    Snacks.picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function()
    Snacks.picker.git_files()
end, { desc = "Find Git Files" })

-- Grep
vim.keymap.set("n", "<leader>sb", function()
    Snacks.picker.lines()
end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", function()
    Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })
vim.keymap.set("n", "<leader>sg", function()
    Snacks.picker.grep()
end, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>sw", function()
    Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })

-- Search
vim.keymap.set("n", "<leader>sd", function()
    Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function()
    Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sh", function()
    Snacks.picker.help()
end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sj", function()
    Snacks.picker.jumps()
end, { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", function()
    Snacks.picker.keymaps()
end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", function()
    Snacks.picker.loclist()
end, { desc = "Location List" })
vim.keymap.set("n", "<leader>sm", function()
    Snacks.picker.marks()
end, { desc = "Marks" })
vim.keymap.set("n", "<leader>sM", function()
    Snacks.picker.man()
end, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sq", function()
    Snacks.picker.qflist()
end, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sR", function()
    Snacks.picker.resume()
end, { desc = "Resume" })
vim.keymap.set("n", "<leader>su", function()
    Snacks.picker.undo()
end, { desc = "Undo History" })
