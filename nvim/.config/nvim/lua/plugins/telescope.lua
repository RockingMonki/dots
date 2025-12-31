return {
  "nvim-telescope/telescope.nvim",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } 
  },
  config = function()
    require("telescope").setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      },
    })
    -- Load fzf extension for better performance
    require("telescope").load_extension("fzf")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "telescope find files" })
    vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "telescope live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "telescope find buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "telescope help page" })
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "telescope find oldfiles" })
    vim.keymap.set("n", "<leader>fa", function ()
      require("telescope.builtin").find_files({
        hidden = true,
        no_ignore = true,
      })
    end, {desc = "telescope find all files"})
  end,
}
