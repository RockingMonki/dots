vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("n", "<leader>q", "<CMD>q<CR>", { desc = "Quick exit", silent = true })

-- buffer management
map("n", "<leader>bd", "<CMD>bdelte<CR>", { desc = "Buf del" })
map("n", "<leader>bn", "<CMD>bnext<CR>", { desc = "Buf next" })
map("n", "<leader>bp", "<CMD>bprevious<CR>", { desc = "Buf prev" })

-- Make pasting over a selection not overwrite the clipboard
vim.keymap.set("x", "p", [["_dP]])
-- Ctrl+C to copy in Visual Mode
vim.keymap.set("v", "<C-c>", '"+y')
-- Ctrl+V to paste in Insert Mode (This is very helpful)
vim.keymap.set("i", "<C-v>", "<C-r>+")
