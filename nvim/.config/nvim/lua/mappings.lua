require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>q", "<CMD>q<CR>")

map("n", "<leader>bn", "<CMD>bnext<CR>")
map("n", "<leader>bd", "<CMD>bdelete<CR>")
map("n", "<leader>bp", "<CMD>bprevious<CR>")

map("n", "<leader>q", "<CMD>q<CR>")
