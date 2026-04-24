return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  opts = {},
  config = function(_, opts)
    require("mason").setup(opts)
  end,
}