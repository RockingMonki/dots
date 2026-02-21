return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        position = "left",
        width = 30,
        mapping = {
          ["<space>"] = "none",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["h"] = "open_split",
        },
      },
    })
  end,
}
