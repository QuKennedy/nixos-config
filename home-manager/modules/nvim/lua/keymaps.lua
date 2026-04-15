vim.g.netrw_liststyle = 0
vim.g.netrw_banner = 0

-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves Line Up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Search Result" })

vim.keymap.set("n", "<C-S-Tab>", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<leader><leader>[", "<cmd>bprev<CR>", { desc = "Previous buffer" })
-- vim.keymap.set("n", "<leader><leader>]", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader><leader>l", "<cmd>b#<CR>", { desc = "Last buffer" })
vim.keymap.set("n", "<leader><leader>d", "<cmd>bdelete<CR>", { desc = "delete buffer" })

-- Jump to previous cursor location (Jumplist)
vim.keymap.set("n", "<C-m>", "<C-o>", { desc = "Jump to previous location" })
-- Jump to next cursor location (Jumplist)
vim.keymap.set("n", "<C-,>", "<C-i>", { desc = "Jump to next location" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>pwd", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy file path to clipboard" })

-- Diagnostic keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Normal Mode: Toggle line comment
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment" })

-- Visual Mode: Toggle comment on selection
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment" })

-- Insert Mode: Toggle comment and stay in insert (if you want that)
vim.keymap.set("i", "<C-/>", "<esc>gcci", { remap = true, desc = "Toggle comment" })
vim.keymap.set("i", "<C-_>", "<esc>gcci", { remap = true, desc = "Toggle comment" })

-- Clipboard keymaps
-- kickstart.nvim starts you with this.
-- But it constantly clobbers your system clipboard whenever you delete anything.
-- You should instead use these keybindings so that they are still easy to use, but dont conflict
-- See `:help 'clipboard'`
vim.keymap.set({ "v", "x", "n" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.keymap.set(
    { "n", "v", "x" },
    "<leader>Y",
    '"+yy',
    { noremap = true, silent = true, desc = "Yank line to clipboard" }
)
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set(
    "i",
    "<C-p>",
    "<C-r><C-p>+",
    { noremap = true, silent = true, desc = "Paste from clipboard from within insert mode" }
)
vim.keymap.set(
    "x",
    "<leader>P",
    '"_dP',
    { noremap = true, silent = true, desc = "Paste over selection without erasing unnamed register" }
)
