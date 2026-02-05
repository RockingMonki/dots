return {
  "nvim-mini/mini.nvim",
  config = function()
    require("mini.pairs").setup()
    require("mini.indentscope").setup({
      symbol = "|",
      options = { try_as_border = true },
    })
  end,
}
