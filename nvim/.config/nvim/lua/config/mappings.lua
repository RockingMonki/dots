local map = vim.keymap.set

map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit", silent = true })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write", silent = true })

-- buffer management
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buf", silent = true })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buf", silent = true })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev buf", silent = true })

-- plugins
-- Diffview
map("n", "<leader>do", "<cmd>DiffviewOpen<cr>", { desc = "Open Diff View", silent = true })
map("n", "<leader>dc", "<cmd>DiffviewClose<cr>", { desc = "Close Diff View", silent = true })

-- Telescope git integration
map("n", "<leader>gc", "<cmd>Telescope ")
