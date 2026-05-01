local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })

map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })
map("n", "j", "gj", { desc = "Move down by visual line" })
map("n", "k", "gk", { desc = "Move up by visual line" })
map("n", "H", "^", { desc = "Move to line start" })
map("n", "L", "$", { desc = "Move to line end" })

map("n", "<leader>h", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Close current window" })
map("n", "<leader>o", "<cmd>only<cr>", { desc = "Keep only current window" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to down window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to up window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

map("n", "<Tab>", ":bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bd<cr>", { desc = "Delete buffer" })
map("n", "<leader>ba", ":bufdo bd<cr>", { desc = "Delete all buffers" })

map("n", "<leader>/", ":_commentary<cr>", { desc = "Toggle comment" })
map("v", "<leader>/", ":commentary<cr>", { desc = "Toggle comment" })

map("n", "Y", "y$", { desc = "Yank to end of line" })

map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Previous search result" })

map("n", "J", "mzJ`z", { desc = "Join lines" })

map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undo tree" })

map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
map("n", "<leader>p", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "<leader>n", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

map("i", "jj", "<Esc>", { desc = "Exit insert mode" })
