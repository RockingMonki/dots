return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- fastest sorter
    "nvim-tree/nvim-web-devicons",                                   -- icons
    "nvim-telescope/telescope-file-browser.nvim",                    -- tree-like browsing
    "nvim-telescope/telescope-frecency.nvim",                        -- frecency sorting
    "nvim-telescope/telescope-ui-select.nvim",                       -- replaces vim.ui.select
    "nvim-telescope/telescope-project.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions   = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix   = "   ",   -- needs Nerd Font
        selection_caret = "  ",
        path_display    = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical   = { mirror = false },
        },
        mappings = {
          i = {
            ["<C-k>"]     = actions.move_selection_previous,
            ["<C-j>"]     = actions.move_selection_next,
            ["<C-q>"]     = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-x>"]     = actions.delete_buffer,   -- delete buffer in buffer list
            ["<Esc>"]     = actions.close,
            ["<C-u>"]     = false,                   -- clear prompt on C-u (no scroll)
          },
        },
        file_ignore_patterns = { "node_modules", ".git/", "dist/", "%.lock" },
      },
      pickers = {
        find_files = {
          hidden = true,           -- include dotfiles
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }, -- fd is faster than find
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
        buffers = {
          sort_lastused = true,
          previewer     = false,   -- fast buffer switcher
        },
      },
      extensions = {
        fzf = {
          fuzzy                   = true,
          override_generic_sorter = true,
          override_file_sorter    = true,
          case_mode               = "smart_case",
        },
        file_browser = {
          hijack_netrw = true,     -- replaces netrw
          hidden       = true,
          grouped      = true,     -- folders first
          previewer    = false,    -- faster
          initial_mode = "normal",
          layout_config = { height = 0.9 },
        },
        frecency = {
          show_scores        = false,
          show_unindexed     = true,
          ignore_patterns    = { "*.git/*", "*/tmp/*" },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("frecency")
    telescope.load_extension("ui-select")
    telescope.load_extension("project")

    local builtin = require("telescope.builtin")
    local map     = vim.keymap.set

    -- Core finders
    map("n", "<leader>ff", builtin.find_files,                       { desc = "Find files" })
    map("n", "<leader>fg", builtin.live_grep,                        { desc = "Live grep" })
    map("n", "<leader>fb", builtin.buffers,                          { desc = "Buffers" })
    map("n", "<leader>fh", builtin.help_tags,                        { desc = "Help tags" })
    map("n", "<leader>fr", builtin.oldfiles,                         { desc = "Recent files" })
    map("n", "<leader>fR", "<cmd>Telescope frecency<cr>",            { desc = "Frecency files" })
    map("n", "<leader>fs", builtin.grep_string,                      { desc = "Grep word under cursor" })
    map("n", "<leader>fp", "<cmd>Telescope project<cr>", { desc = "Switch project", silent = true })

    -- File browser (tree-like explorer)
    map("n", "<leader>fe", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "File browser" })
    map("n", "<leader>fE", "<cmd>Telescope file_browser<cr>",        { desc = "File browser (cwd)" })

    -- Git
    map("n", "<leader>gc", builtin.git_commits,                      { desc = "Git commits" })
    map("n", "<leader>gb", builtin.git_branches,                     { desc = "Git branches" })
    map("n", "<leader>gs", builtin.git_status,                       { desc = "Git status" })

    -- LSP
    map("n", "<leader>fd", builtin.lsp_definitions,                  { desc = "LSP definitions" })
    map("n", "<leader>fi", builtin.lsp_implementations,              { desc = "LSP implementations" })
    map("n", "<leader>ft", builtin.lsp_type_definitions,             { desc = "Type definitions" })
    map("n", "gr",         builtin.lsp_references,                   { desc = "LSP references" })

    -- Misc
    map("n", "<leader>fk", builtin.keymaps,                          { desc = "Keymaps" })
    map("n", "<leader>f/", builtin.current_buffer_fuzzy_find,        { desc = "Fuzzy in buffer" })
  end,
}
