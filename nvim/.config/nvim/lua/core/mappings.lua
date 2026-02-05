-- =========================
-- Keymaps
-- =========================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =========================
-- General
-- =========================

map("n", "<leader>w", "<cmd>w<cr>", opts)      -- Save
map("n", "<leader>q", "<cmd>q<cr>", opts)      -- Quit
map("n", "<leader>Q", "<cmd>qa!<cr>", opts)    -- Force quit all
map("n", "<leader>c", "<cmd>bd<cr>", opts)     -- Close buffer

-- Clear search highlight
map("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)

-- =========================
-- Better movement
-- =========================

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- =========================
-- Indenting
-- =========================

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- =========================
-- Yanking / Pasting
-- =========================

-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", '"+y', opts)
map("n", "<leader>Y", '"+Y', opts)

-- Paste without overwriting register
map("x", "<leader>p", '"_dP', opts)

-- =========================
-- Text manipulation
-- =========================

-- Move selected lines
map("v", "J", ":m '>+1<cr>gv=gv", opts)
map("v", "K", ":m '<-2<cr>gv=gv", opts)

-- Join lines without moving cursor
map("n", "J", "mzJ`z", opts)

-- =========================
-- Windows / Splits
-- =========================

map("n", "<leader>sv", "<cmd>vsplit<cr>", opts)
map("n", "<leader>sh", "<cmd>split<cr>", opts)
map("n", "<leader>se", "<C-w>=", opts)         -- Equal size
map("n", "<leader>sx", "<cmd>close<cr>", opts)

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- =========================
-- Tabs
-- =========================

map("n", "<leader>tn", "<cmd>tabnew<cr>", opts)
map("n", "<leader>tc", "<cmd>tabclose<cr>", opts)
map("n", "<leader>tl", "<cmd>tabnext<cr>", opts)
map("n", "<leader>th", "<cmd>tabprevious<cr>", opts)

-- =========================
-- Terminal
-- =========================

-- Open terminal
map("n", "<leader>tt", "<cmd>terminal<cr>", opts)

-- Escape terminal mode easily
map("t", "<Esc>", "<C-\\><C-n>", opts)
-- Next / previous tab
vim.keymap.set("n", "<C-Tab>", "<cmd>tabnext<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Tab>", "<cmd>tabprevious<cr>", { noremap = true, silent = true })
