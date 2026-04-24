return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle explorer" },
  },
  opts = {
    view = {
      width = 40,
      side = "left",
      signcolumn = "no",
      number = false,
      relativenumber = false,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      icons = {
        show = {
          folder = true,
          file = true,
          folder_arrow = false,
          git = true,
        },
      },
    },
    filters = {
      custom = { "^.git$", "^node_modules" },
      exclude = { ".gitignore" },
    },
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}