return {
	"neovim/nvim-lspconfig",
	dependencies = {
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
			textDocument = {
				foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true
				}
			}
		}

		capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

		vim.lsp.config('lua_ls', {
			capabilities = capabilities,
		})

		vim.lsp.config("clangd", {
			capabilities = capabilities,
		})

		vim.lsp.enable({ 'lua_ls', "clangd" })
	end,
}
