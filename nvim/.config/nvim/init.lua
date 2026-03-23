require "config.options" -- load options
require "config.mappings" -- load mappings
require "config.autocmd"
require "config.lazy"

vim.opt.list = true
-- Multispace allows you to define a lead character and a filler
-- Here, we use a vertical bar followed by spaces
vim.opt.listchars:append {
  multispace = "│ ",
  leadmultispace = "│ ",
}

-- Optional: Make the lines subtle by changing the highlight group
-- 'NonText' or 'Whitespace' are common targets
vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4252" }) -- Adjust color to your theme
vim.opt.listchars:append { multispace = "│ ", leadmultispace = "│ " }
