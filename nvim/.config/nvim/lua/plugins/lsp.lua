return {
  "neovim/nvim-lspconfig",
  dependecies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    local capabilities = {
      textDocumnet = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
        }
      }
    }

    capabilities = require('blink.cmp').get_lsp_capabilities(capabilites)

    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
    })

    vim.lsp.enable({
      'lua_ls'
    })
  end,
}
