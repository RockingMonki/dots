return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    require("mini.pairs").setup()
    require("mini.ai").setup()
    require("mini.git").setup()
    require("mini.icons").setup()
  end,
}
