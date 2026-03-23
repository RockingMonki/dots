return {
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()
    require("mini.pairs").setup()
  end,
}
