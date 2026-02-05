local opt = vim.opt

opt.compatible = false
opt.termguicolors = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.showmode = false
opt.laststatus = 3
opt.cmdheight = 1
opt.pumheight = 10

opt.winblend = 0
opt.pumblend = 0
opt.winborder = "rounded"

-- Editing Behavior 

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true

opt.clipboard = "unnamedplus"

-- Search 
opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"

opt.updatetime = 200
opt.timeoutlen = 400
opt.lazyredraw = true

opt.mouse = "a"

vim.opt.shortmess:append("I")
