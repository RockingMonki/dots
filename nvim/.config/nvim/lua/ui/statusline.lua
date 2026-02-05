-- lua/ui/statusline.lua
-- Clean, native statusline with LSP info (no icons)
-- Neovim 0.10+ compatible
-- Usage: require('ui.statusline').setup()

local M = {}

-- =========================
-- Helpers
-- =========================

local function mode_short()
  local m = vim.api.nvim_get_mode().mode
  local modes = {
    n = 'NORMAL',
    no = 'N·OPER',
    i = 'INSERT',
    ic = 'INSERT',
    v = 'VISUAL',
    V = 'V-LINE',
    ['\22'] = 'V-BLOCK',
    c = 'COMMAND',
    R = 'REPLACE',
    t = 'TERMINAL',
  }
  return modes[m] or m
end

local function file_info()
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
  if name == '' then name = '[No Name]' end
  if vim.bo.modified then name = name .. ' [+]' end
  return name
end

local function git_branch()
  if vim.b.gitsigns_head and vim.b.gitsigns_head ~= '' then
    return vim.b.gitsigns_head
  end
  return ''
end

local function diagnostics()
  local diags = vim.diagnostic.get(0)
  if not diags or vim.tbl_isempty(diags) then return '' end

  local e, w, i, h = 0, 0, 0, 0
  for _, d in ipairs(diags) do
    if d.severity == vim.diagnostic.severity.ERROR then e = e + 1 end
    if d.severity == vim.diagnostic.severity.WARN  then w = w + 1 end
    if d.severity == vim.diagnostic.severity.INFO  then i = i + 1 end
    if d.severity == vim.diagnostic.severity.HINT  then h = h + 1 end
  end

  local out = {}
  if e > 0 then table.insert(out, 'E:' .. e) end
  if w > 0 then table.insert(out, 'W:' .. w) end
  if i > 0 then table.insert(out, 'I:' .. i) end
  if h > 0 then table.insert(out, 'H:' .. h) end

  return table.concat(out, ' ')
end

local function lsp_info()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if not clients or vim.tbl_isempty(clients) then
    return ''
  end

  local names = {}
  for _, client in ipairs(clients) do
    if client.name ~= 'null-ls' then
      table.insert(names, client.name)
    end
  end

  if #names == 0 then return '' end
  return 'LSP: ' .. table.concat(names, ', ')
end

local function position()
  local line = vim.fn.line('.')
  local col = vim.fn.col('.')
  local total = vim.fn.line('$')
  local percent = math.floor((line / math.max(total, 1)) * 100)
  return string.format('%d:%d %d%%%%', line, col, percent)
end

-- =========================
-- Statusline builder
-- =========================

function M.build()
  local left = string.format(
    ' %%#StatusLineMode# %s %%#StatusLine# %s ',
    mode_short(),
    file_info()
  )

  local middle = ''

  local diag = diagnostics()
  if diag ~= '' then middle = middle .. ' ' .. diag end

  local branch = git_branch()
  if branch ~= '' then middle = middle .. ' git:' .. branch end

  local lsp = lsp_info()
  if lsp ~= '' then middle = middle .. ' ' .. lsp end

  local right = string.format(
    ' %%= %s %s %s %s ',
    position(),
    vim.bo.filetype ~= '' and vim.bo.filetype or 'noft',
    vim.o.encoding,
    vim.bo.fileformat
  )

  return left .. middle .. right
end

-- =========================
-- Setup
-- =========================

function M.setup()
  vim.o.statusline = "%!v:lua.require'ui.statusline'.build()"

  vim.cmd([[
    hi default StatusLine guibg=NONE guifg=#bbbbbb
    hi default StatusLineMode guibg=NONE guifg=#ffcc66 gui=bold
  ]])
end

return M
