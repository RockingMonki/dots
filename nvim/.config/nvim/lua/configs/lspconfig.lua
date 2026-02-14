require("nvchad.configs.lspconfig").defaults()

local servers = { "lua_ls", "rust_analyzer"}
vim.lsp.enable(servers)

