-- NOTE: These 2 need to be set up before any plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd.colorscheme("catppuccin-mocha")

require("options")
require("autocmds")
require("keymaps")

require("plugins.snacks.config")
require("plugins.snacks.keymaps")

require("plugins.editing")
require("plugins.ui")
require("plugins.git")
require("plugins.tools")
require("plugins.lsp")
