return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
    { "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal file" },
    { "<leader>ge", "<cmd>Neotree git_status<cr>", desc = "Git explorer" },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",

    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
      },
      git_status = {
        symbols = {
          added     = "A",
          modified  = "M",
          deleted   = "D",
          renamed   = "R",
          untracked = "?",
          ignored   = "!",
          unstaged  = "U",
          staged    = "S",
          conflict  = "C",
        },
      },
    },

    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { ".DS_Store", "thumbs.db" },
        never_show = { ".git" },
      },
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      group_empty_dirs = true,
    },

    window = {
      position = "left",
      width = 35,
      mappings = {
        ["<space>"] = "none",
        ["l"] = "open",
        ["h"] = "close_node",
        ["<CR>"] = "open",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["a"] = { "add", config = { show_path = "relative" } },
        ["d"] = "delete",
        ["r"] = "rename",
        ["c"] = "copy",
        ["m"] = "move",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["H"] = "toggle_hidden",
        -- Git commands
        ["ga"] = "git_add_file",
        ["gu"] = "git_unstage_file",
        ["gr"] = "git_revert_file",
      },
    },

    -- Dedicated git status panel
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"]  = "git_add_all",
          ["ga"] = "git_add_file",
          ["gu"] = "git_unstage_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        },
      },
    },

    event_handlers = {
      -- Auto close on file open
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
