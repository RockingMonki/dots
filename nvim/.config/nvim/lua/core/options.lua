-- options.lua — Neovim options only (no plugins, no keymaps)
local o = vim.opt
local g = vim.g

-- Leader (even if you later add keymaps)
g.mapleader = ' '
g.maplocalleader = ' '

-- UI
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = 'yes'
o.termguicolors = true
o.showmode = false
o.wrap = false
o.scrolloff = 8
o.sidescrolloff = 8

-- Editing
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.smartindent = true
o.autoindent = true
o.breakindent = true

-- Clipboard & mouse
o.clipboard = 'unnamedplus'
o.mouse = 'a'

-- Search
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

-- Splits
o.splitbelow = true
o.splitright = true

-- Files & backups
o.undofile = true
o.backup = false
o.writebackup = false
o.swapfile = false
o.autoread = true

-- Performance
o.updatetime = 200
o.timeoutlen = 500
o.lazyredraw = true
o.redrawtime = 10000

-- Completion
o.completeopt = { 'menu', 'menuone', 'noselect' }

-- Folding (modern defaults; enable expr later if using Treesitter)
o.foldmethod = 'manual'
o.foldlevel = 99

-- Whitespace & formatting helpers
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.formatoptions:remove({ 'c', 'r', 'o' })

-- Line numbers in terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Disable unused providers for faster startup
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
