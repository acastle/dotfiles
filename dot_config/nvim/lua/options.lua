local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.wrap = false
opt.termguicolors = true
opt.showmode = false

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.undofile = true

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

opt.splitright = true
opt.splitbelow = true

vim.g.clipboard = "osc52"
opt.clipboard = "unnamedplus"

opt.timeoutlen = 1000
opt.updatetime = 200
opt.confirm = true
opt.completeopt = "menu,menuone,noselect"
