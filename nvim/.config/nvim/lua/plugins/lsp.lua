return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    local capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    }

    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

    vim.lsp.config("clangd", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
    })

    vim.lsp.config("basedpyright", {
      capabilities = capabilities,
    })

    vim.lsp.config("gopls", {
      capabilities = capabilities,
    })

    vim.lsp.enable { "clangd", "lua_ls", "basedpyright", "gopls" }

    -- diagnostics
    vim.diagnostic.config {
      virtual_text = {
        prefix = "●", -- Small dot instead of a block
        spacing = 2,
      },
      float = {
        border = "rounded",
        source = "always", -- Show the name of the LSP (e.g., "basedpyright")
      },
      signs = true,
      underline = true,
      update_in_insert = false, -- Don't show errors while you are still typing
      severity_sort = true,
    }
  end,
}
