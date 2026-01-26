local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic saves / quits
map('n', '<leader>w', ':w<CR>', opts)
map('n', '<leader>q', ':q<CR>', opts)

-- Buffer navigation
map('n', '<Tab>', ':bnext<CR>', opts)
map('n', '<S-Tab>', ':bprevious<CR>', opts)
map('n', '<leader>bd', ':bdelete<CR>', opts)

-- Window management (simple)
map('n', '<leader>sv', ':vsplit<CR>', opts)
map('n', '<leader>sh', ':split<CR>', opts)
map('n', '<leader>se', ':wincmd =<CR>', opts) -- equalize
map('n', '<leader>sx', ':close<CR>', opts)

-- Yank / Paste helpers (system clipboard-aware)
map('n', '<leader>yy', '"+yy', opts)        -- yank line to system clipboard
map('v', '<leader>y', '"+y', opts)         -- yank visual selection to system clipboard
map('n', '<leader>Y', '"+y$', opts)        -- yank to end of line
map('n', '<leader>p', '"+p', opts)         -- paste from system clipboard
map('n', '<leader>P', '"+P', opts)         -- paste before cursor from system clipboard
map('n', '<leader>ya', ':%y+<CR>', opts)    -- yank entire buffer to system clipboard

-- Paste in visual without overwriting the unnamed register (keep clipboard)
map('v', 'p', '"_dP', opts)

-- Delete without yanking
map('n', 'x', '"_x', opts)
map('v', 'x', '"_x', opts)

-- Move lines up/down
map('n', '<A-j>', ':m .+1<CR>==', opts)
map('n', '<A-k>', ':m .-2<CR>==', opts)
map('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
map('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Keep visual indenting when shifting
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Join lines without moving cursor
map('n', 'J', 'mzJ`z', opts)

-- Select all
map('n', '<leader>sa', 'ggVG', opts)

-- Quick replace: search & replace word under cursor in whole file (press <Enter> to run)
map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Formatting (if LSP attached)
map('n', '<leader>f', function() if vim.lsp.buf.format then vim.lsp.buf.format({ async = true }) end end, opts)

-- Diagnostics quick peek
map('n', '<leader>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)

-- Terminal: easy escape to normal mode
map('t', '<Esc>', [[<C-\><C-n>]], opts)

-- Preserve undo when joining or making edits (optional small polish)
-- These are examples of mappings that don't clobber the undo tree; adjust if needed.
map('n', 'U', '<C-r>', opts) -- redo (keeping caps U as redo alternative)
