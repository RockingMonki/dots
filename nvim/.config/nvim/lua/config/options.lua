local opt = vim.opt

-- configuring leader and local leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- options for the editor
opt.number = true
opt.cmdheight = 0
opt.wrap = false
opt.swapfile = false
opt.undofile = true
opt.clipboard = "unnamedplus"
opt.termguicolors = true -- True color support
opt.ignorecase = true -- Case insensitive searching
opt.smartcase = true -- ... unless capital letter is used
opt.cursorline = true -- Highlight current line
opt.splitright = true -- Splits go to the right
opt.splitbelow = true -- Splits go below
opt.shiftwidth = 2
opt.winborder = "rounded"
opt.termguicolors = true
