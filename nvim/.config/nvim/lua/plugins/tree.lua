return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- for file icons
  },
  config = function()
    require("nvim-tree").setup({})
    -- Disable netrw at the very start (recommended by nvim-tree)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
        side = "left",         -- or "right"
      },
      renderer = {
        group_empty = true,    -- group empty folders like a/b/c
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
        highlight_git = true,
        highlight_opened_files = "name",
      },
      filters = {
        dotfiles = false,      -- set true to hide dotfiles
        custom = { "^.git$" },
      },
      git = {
        enable = true,
        ignore = false,        -- show git-ignored files (greyed out)
      },
      actions = {
        open_file = {
          quit_on_open = false,  -- keep tree open after opening a file
          window_picker = {
            enable = true,
          },
        },
      },
    })

    local map = vim.keymap.set

    map("n", "<C-n>",  ":NvimTreeToggle<CR>",   { desc = "Toggle file tree", silent = true })
    map("n", "<leader>tf", ":NvimTreeFocus<CR>",    { desc = "Focus file tree", silent = true})
    map("n", "<leader>cf", ":NvimTreeFindFile<CR>", { desc = "Find current file in tree", silent = true })
  end,
}
