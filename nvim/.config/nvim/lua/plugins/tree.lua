return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      filters = { dotfiles = true },
      disable_netrw = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = { 
        width = 30,
        preserve_window_proportions = true,
        side = "left",
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            default = "󰈚",
            folder = {
              default = "󰉋",
              empty = "󰜌",
              open = "󰝰",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
    })

    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "nvimtree toggle window", silent = true })
    vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = "nvimtree focus window", silent = true })
  end,
}
