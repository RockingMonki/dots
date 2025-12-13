return {
  "nvim-mini/mini.nvim",
  config = function()
    require("mini.pairs").setup()
    require("mini.statusline").setup()
    require("mini.icons").setup()
    require("mini.tabline").setup()
  end,
}
