return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Search word" },
  },
  opts = {
    defaults = {
      hidden = true,
      no_ignore = true,
      file_ignore_patterns = { "node_modules", ".git", "dist", "build", "__pycache__" },
    },
  },
}
