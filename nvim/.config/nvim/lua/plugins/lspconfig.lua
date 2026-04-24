return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/lazydev.nvim",
    "saghen/blink.cmp",
    "j-hui/fidget.nvim",
  },
  config = function()
    vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"
    require("fidget").setup({})

    local libs = {}
    pcall(function() libs = require("lazydev.library") end)

    vim.lsp.config("lua_ls", {
      cmd = { "lua-language-server" },
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.list_extend(libs, vim.api.nvim_get_runtime_file("", true)),
          },
        },
      },
    })
    vim.lsp.enable("lua_ls")
  end,
}
