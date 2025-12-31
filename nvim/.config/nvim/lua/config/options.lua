local opt = vim.opt

-- --- Global Settings ---
opt.mouse = "a"               -- Enable mouse support
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = { "menuone", "noselect" } -- Better completion experience
opt.confirm = true            -- Confirm to save changes before exiting modified buffer
opt.undofile = true           -- Save undo history to file

-- --- UI / Visuals ---
opt.number = true             -- Show line numbers
opt.relativenumber = true     -- Relative line numbers (great for motions)
opt.splitbelow = true         -- Put new windows below current
opt.splitright = true         -- Put new windows right of current
opt.termguicolors = true      -- True color support
opt.cursorline = true         -- Highlight the current line
opt.signcolumn = "yes"        -- Always show the sign column (prevents flickering)
opt.laststatus = 3            -- Global statusline (one for all windows)
opt.scrolloff = 10            -- Keep at least 10 lines above/below cursor

-- --- Search ---
opt.ignorecase = true         -- Ignore case in search patterns
opt.smartcase = true          -- Case-sensitive if there's a capital letter
opt.hlsearch = true           -- Highlight all matches
opt.incsearch = true          -- Show search results while typing

-- --- Indentation / Tabs ---
opt.expandtab = true          -- Use spaces instead of tabs
opt.shiftwidth = 2            -- Size of an indent
opt.smartindent = true        -- Insert indents automatically
opt.tabstop = 2               -- Number of spaces tabs count for
opt.softtabstop = 2           -- Number of spaces for a tab while editing

-- --- Performance & Behavior ---
opt.updatetime = 250          -- Faster completion and diagnostic updates
opt.timeoutlen = 300          -- Time to wait for a mapped sequence
opt.backup = false            -- Don't create backup files
opt.writebackup = false       -- Don't create backup files
opt.swapfile = false          -- Don't use swapfiles
opt.wrap = false              -- Disable line wrapping
