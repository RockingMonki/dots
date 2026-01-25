-- mappings.lua — Neovim keymaps only
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader (in case this file is sourced standalone)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic
map('n', '<leader>w', '<cmd>w<CR>', opts)
map('n', '<leader>q', '<cmd>q<CR>', opts)
map('n', '<leader>Q', '<cmd>qa!<CR>', opts)

-- Better window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Resize splits
map('n', '<C-Up>', ':resize +2<CR>', opts)
map('n', '<C-Down>', ':resize -2<CR>', opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Clear search highlight
map('n', '<leader>h', '<cmd>nohlsearch<CR>', opts)

-- Yanking to system clipboard
map({'n','v'}, '<leader>y', '"+y', opts)
map('n', '<leader>Y', '"+Y', opts)

-- Pasting from system clipboard
map({'n','v'}, '<leader>p', '"+p', opts)
map({'n','v'}, '<leader>P', '"+P', opts)

-- Paste without overwriting register (visual mode)
map('v', 'p', '"_dP', opts)

-- Keep selection when indenting
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Move selected lines
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Terminal management
-- Open terminal in split
map('n', '<leader>tt', '<cmd>split | terminal<CR>', opts)
map('n', '<leader>tv', '<cmd>vsplit | terminal<CR>', opts)

-- Close terminal buffer quickly
map('t', '<leader>tc', '<cmd>exit<CR>', opts)

-- Escape terminal mode easily
map('t', '<Esc>', '<C-\\><C-n>', opts)

-- Toggle last terminal (simple)
map('n', '<leader>tb', '<cmd>b#<CR>', opts)

-- Better paste in insert mode (from system clipboard)
map('i', '<C-v>', '<C-r>+', { noremap = true })

-- Yank entire buffer
map('n', '<leader>ya', ':%y+<CR>', opts)

-- Quick source current file
map('n', '<leader>so', '<cmd>source %<CR>', opts)
