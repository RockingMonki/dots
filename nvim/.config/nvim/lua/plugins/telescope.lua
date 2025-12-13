-- ~/.config/nvim/lua/plugins/telescope.lua

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    -- Find files (includes hidden, excludes .git)
    { "<leader>ff", function()
        require("telescope.builtin").find_files({ hidden = true })
      end, desc = "Find files" },

    -- Find ALL files (hidden + gitignored)
    { "<leader>fa", function()
        require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
      end, desc = "Find all files" },

    -- Grep (includes hidden)
    { "<leader>fg", function()
        require("telescope.builtin").live_grep({
          additional_args = { "--hidden", "-g", "!.git" }
        })
      end, desc = "Live grep" },

    -- Word under cursor
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find word" },

    -- Common pickers
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search buffer" },

    -- Git
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },

    -- Resume last search
    { "<leader>fR", "<cmd>Telescope resume<cr>", desc = "Resume" },
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " → ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.5,
          },
          width = 0.85,
          height = 0.80,
        },

        -- Include hidden files by default
        vimgrep_arguments = {
          "rg", "--color=never", "--no-heading", "--with-filename",
          "--line-number", "--column", "--smart-case",
          "--hidden", "-g", "!.git"
        },

        -- Ignore these
        file_ignore_patterns = { "^.git/", "node_modules" },

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
      },

      pickers = {
        find_files = {
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
        },
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}
