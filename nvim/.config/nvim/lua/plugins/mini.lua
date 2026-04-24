return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.ai").setup()
    require("mini.bracketed").setup()
    require("mini.move").setup()
    require("mini.operators").setup()
    require("mini.sessions").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()
    require("mini.git").setup()
    require("mini.diff").setup()
    require("mini.indentscope").setup()
    require("mini.icons").setup()
    require("mini.pairs").setup()
  end,
}
