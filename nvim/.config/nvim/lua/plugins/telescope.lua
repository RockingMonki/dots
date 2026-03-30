return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").setup {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "target",
          ".git",
          "dist",
          "build",
          "%.lock",
          "__pycache__",
          "%.a",
          "%.o",
          "%.out",
        },
      },
    }

    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    vim.keymap.set("n", "<leader>fa", function()
      require("telescope.builtin").find_files {
        hidden = true,
        no_ignore = true,
      }
    end, { desc = "Find all", silent = true })
  end,
}
