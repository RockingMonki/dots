local map = vim.keymap.set 

map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit", silent = true })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write", silent = true })

-- buffer management
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buf", silent = true })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buf", silent = true })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev buf", silent = true })

