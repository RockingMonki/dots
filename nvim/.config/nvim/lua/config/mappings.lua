local map = vim.keymap.set

-- Set leader key to space (highly recommended)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- --- Better Yanking & Pasting ---

-- Keep cursor in place when yanking
-- (By default, the cursor jumps to the start of the yank)
map("v", "y", "ygv<Esc>")

-- Yank from cursor to end of line (makes 'Y' behave like 'D' or 'C')
map("n", "Y", "y$")

-- "Greatest Paste Ever" (The Primeagen special)
-- When you highlight text and paste over it, keep the original yanked text in the buffer.
-- This prevents the deleted text from overwriting your register.
map("x", "<leader>p", [["_dP]])

-- Yank into system clipboard (in addition to your options.lua settings)
-- Useful if you want to be explicit about sending to system clip
map({"n", "v"}, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- Delete into the void (does not overwrite your yanked text)
map({"n", "v"}, "<leader>d", [["_d]])

-- --- General Ease of Use ---

-- Use JK to exit insert mode (much faster than hitting Esc)
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Move visual blocks up and down with K and J
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered during half-page jumps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Keep search terms centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Better indenting (stay in visual mode after shifting)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear search highlights with <Esc>
map("n", "<Esc>", "<cmd>noh<CR>")

