return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    require("onedarkpro").setup {
      options = {
        transparency = true, -- Highly recommended for a modern look
        cursorline = true, -- Highlight the current line
        highlight_inactive_windows = true,
      },
      styles = {
        types = "italic", -- Class names and types in italics look classy
        methods = "bold", -- Methods/Functions in bold for better scannability
      },
    }
    vim.cmd "colorscheme onedark"
  end,
}
