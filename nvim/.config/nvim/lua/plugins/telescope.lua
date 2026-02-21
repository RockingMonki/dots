return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require("telescope").setup {
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
          -- include hidden files by default
          hidden = true,
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            hidden = true,     -- show hidden files
            no_ignore = true,  -- do not respect .gitignore
          },
          buffers = {
            theme = "dropdown",
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }

      -- load fzf extension
      require("telescope").load_extension("fzf")
    end,
  },
}
