-- Set leader keys before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("options")
require("plugins")
require("keymaps")
require("autocmds")
require("lsp")
