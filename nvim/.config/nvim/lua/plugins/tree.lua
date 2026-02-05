return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      disable_netrw = true,
      hijack_netrw = true,

      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = true,
        signcolumn = "no",
      },

      renderer = {
        highlight_git = true,
        highlight_opened_files = "none",
        root_folder_label = false,
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = false,
          },
        },
      },

      filters = {
        dotfiles = false,
        git_ignored = true,
      },

      git = {
        enable = true,
      },

      actions = {
        open_file = {
          quit_on_open = false,
        },
      },

      diagnostics = {
        enable = false,
      },

      -- IMPORTANT: does not touch statusline
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    })

    -- Keymaps (clean & minimal)
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", opts)
    map("n", "<leader>e", "<cmd>NvimTreeFindFile<cr>", opts)
  end,
}
