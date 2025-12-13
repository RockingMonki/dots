local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.winborder = "rounded"
opt.signcolumn = "yes"
opt.undofile = true
opt.swapfile = false
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shortmess:append("I")
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.clipboard = "unnamedplus"
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

vim.o.cmdheight = 1
