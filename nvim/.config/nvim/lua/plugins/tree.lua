return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  config = function()
    require("nvim-tree").setup {
      view = {
        width = 30,
        side = "left",
      },
      -- Disable netrw (the default vim file explorer)
      disable_netrw = true,
      hijack_netrw = true,
      filters = {
        dotfiles = false, -- Set to true if you want to hide hidden files
      },
    }

    -- Set the keymap to toggle
    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })
  end,
}
