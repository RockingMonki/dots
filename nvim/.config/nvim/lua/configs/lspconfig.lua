require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "lua_ls" }
vim.lsp.enable(servers)
