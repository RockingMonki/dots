return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional but recommended
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
          },
        },

        window = {
          position = "left",
          width = 35,
          mapping_options = { noremap = true, nowait = true },
        },

        filesystem = {
          follow_current_file = { enabled = true }, -- highlight current file
          use_libuv_file_watcher = true,            -- auto-refresh
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
            never_show = { ".DS_Store" },
          },
        },

        buffers = {
          follow_current_file = true,
        },

        -- Do not allow other buffers to take over the neo-tree window
        -- (neo-tree is designed to be polite and keep its side-panel intact)
      })

      -- toggle keymap (adjust to your leader if it's different)
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { noremap = true, silent = true })

      -- optional: key to reveal the current file in the tree
      vim.keymap.set("n", "<leader>r", "<cmd>Neotree reveal<CR>", { noremap = true, silent = true })
    end,
  },
}
