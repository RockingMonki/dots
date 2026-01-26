return {
  -- File icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
          icons_enabled = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },

        sections = {
          lualine_a = {
            { "mode", icon = "" },
          },

          lualine_b = {
            { "branch", icon = "" },
            "diff",
          },

          lualine_c = {
            {
              "filename",
              file_status = true,
              path = 1,
              symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = "[No Name]",
              },
            },
          },

          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = " ",
                warn  = " ",
                info  = " ",
                hint  = " ",
              },
            },
            "filetype",
            "encoding",
            "fileformat",
          },

          lualine_y = { "progress" },
          lualine_z = { "location" },
        },

        inactive_sections = {
          lualine_c = { "filename" },
          lualine_x = { "location" },
        },
      })
    end,
  },

  -- Tabline / Buffers
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",

          indicator = {
            style = "icon",
            icon = "▎",
          },

          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",

          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,

          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = false,
          show_tab_indicators = true,

          separator_style = "slant",
          always_show_bufferline = true,

          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })

      -- Optional but very useful keymaps
      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
      vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { silent = true })
    end,
  },
}
