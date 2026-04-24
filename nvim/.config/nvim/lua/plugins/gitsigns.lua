return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "│" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    current_line_blame = false,
    attach_to_untracked = true,
    update_debounce = 100,
    max_file_length = 40000,
  },
}