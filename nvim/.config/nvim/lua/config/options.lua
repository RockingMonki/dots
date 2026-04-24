local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.numberwidth = 1
opt.swapfile = false
opt.cmdheight = 0
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.clipboard = "unnamedplus"
opt.timeout = false
opt.updatetime = 200
opt.undofile = true
opt.termguicolors = true
opt.hidden = true
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore = "*.jpg,*.jpeg,*.png,*.gif,*.zip,*.obj,*.o,*.bin,*.pdf,*.pyc,*.png,*.jpeg,*.svg"
opt.completeopt = "menu,menuone,noinsert"
opt.pumheight = 10
opt.conceallevel = 0
opt.showmode = false
opt.showtabline = 2
opt.laststatus = 3
opt.matchtime = 1
opt.magic = true
opt.formatoptions = "croqnl"
opt.linebreak = true
opt.breakindent = true
opt.wrap = false
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.cindent = false
opt.mouse = "a"
opt.iskeyword:append("-")
opt.shortmess:append("c")
opt.whichwrap:append("<>[]hl")
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.winborder = "rounded"
opt.laststatus = 3

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
