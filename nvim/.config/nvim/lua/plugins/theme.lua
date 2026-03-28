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
      highlights = {
        -- Keywords (def, class, in, etc.)
        ["@keyword"] = { bold = true },
        ["@keyword.function"] = { bold = true },
        ["@keyword.operator"] = { bold = true },

        -- Variables/Identifiers
        ["@variable"] = { bold = true },
        ["@parameter"] = { bold = true },
      },
    }
    vim.cmd "colorscheme onedark"
  end,
}
