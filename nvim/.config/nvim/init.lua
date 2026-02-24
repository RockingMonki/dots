local opt = vim.opt
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- options
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.shiftwidth = 2
opt.tabstop = 2
opt.swapfile = false
opt.winborder = 'rounded'
opt.clipboard = "unnamedplus"
opt.virtualedit = "block"
opt.autoindent = true
opt.smartindent = true
opt.undofile = true

vim.g.mapleader = " "

require("config.lazy")

-- mappings 
map('n', '<leader>o', ':update<CR> :so<CR>')
map('n', "<leader>w", ":write<CR>")
map("n", "<leader>q", ":quit<CR>")
-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
map("n", "<leader>fa", "<cmd>Telescope find_files no_ignore=true hidden=true<cr>", opts)
map("n", "<leader>fo", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", opts)
map("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", opts)
map("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", opts)
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "y", '"+y')
vim.keymap.set({ "n", "v" }, "d", '"+d')
vim.keymap.set("n", "Y", '"+Y')
vim.keymap.set("v", "p", '"_dP')

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

vim.cmd.colorscheme "catppuccin"
