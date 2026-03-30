return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "goimports", "gofumpt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        svelte = { "prettier" },
      },
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format { bufnr = args.buf }
      end,
    })
  end,
}
