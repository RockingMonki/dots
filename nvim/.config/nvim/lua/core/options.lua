local o = vim.opt
local g = vim.g

-- UI / Look & Feel
o.termguicolors = true
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.showmode = false
o.laststatus = 3           -- global statusline (nvim 0.7+)
o.cmdheight = 0            -- compact cmdline (nvim 0.9+)
o.pumheight = 10
o.pumblend = 10            -- popup transparency
o.winblend = 0

o.fillchars = {
  fold = ' ',
  eob = ' ',
  diff = '╱',
  msgsep = '‾',
}

-- Rounded borders for floating windows (LSP, hover, etc.)
-- Many plugins respect this via vim.lsp.handlers + vim.ui
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- Diagnostics floating window borders
vim.diagnostic.config({
  float = { border = "rounded" },
  severity_sort = true,
  update_in_insert = false,
})

-- Better splits
o.splitright = true
o.splitbelow = true
o.scrolloff = 8
o.sidescrolloff = 8

-- Editing behavior
o.wrap = false
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.smartindent = true
o.autoindent = true
o.breakindent = true

-- Search
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

-- Performance / UX
o.updatetime = 200
o.timeoutlen = 400
o.lazyredraw = true

-- Clipboard & mouse
o.clipboard = "unnamedplus"
o.mouse = "a"

-- Files & backups
o.swapfile = false
o.backup = false

o.undofile = true
-- Persistent undo directory
local undodir = vim.fn.stdpath("state") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
o.undodir = undodir

-- Folding (nice defaults, works well with treesitter later)
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = false

-- Completion menu behavior
o.completeopt = { "menu", "menuone", "noselect" }

-- Invisible characters (for a clean but helpful look)
o.list = true
o.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "⟩",
  precedes = "⟨",
  nbsp = "␣",
}

-- Disable some built-in providers for faster startup
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0

