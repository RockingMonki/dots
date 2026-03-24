return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- These are desaturated "deep" versions of the One Dark palette
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#5A3E40" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#7A715C" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#4E5C7C" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#82634B" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#5F6B52" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#6F5A77" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#4B6E75" })
    end)

    require("ibl").setup {
      indent = {
        highlight = highlight,
        char = "▎", -- A thinner, cleaner character often looks better with colors
      },
      scope = { enabled = false }, -- Optional: keeps it cleaner
    }
  end,
}
