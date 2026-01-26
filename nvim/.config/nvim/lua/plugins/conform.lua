return
{
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
      },

      format_on_save = {
        enabled = true,
      },
    })

    -- manual format keymap
    vim.keymap.set("n", "<leader>f", function()
      conform.format({ async = true })
    end, { desc = "Format buffer" })

    -- force format before save (sync, reliable)
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function()
        pcall(function()
          conform.format({ async = false })
        end)
      end,
    })
  end,
}
