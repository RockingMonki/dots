-- lua/ui/tabbar.lua
-- Clean native tabbar (clickable tabs, buffer list, close buttons)
-- Usage: require('ui.tabbar').setup()

local M = {}

local function filter_float_wins(winids)
  local nonfloats = {}
  for _, winid in ipairs(winids) do
    local ok, cfg = pcall(vim.api.nvim_win_get_config, winid)
    if ok and cfg.relative == "" then
      nonfloats[#nonfloats + 1] = winid
    end
  end
  return nonfloats
end

local function filter_unlisted_buffers(bufnums)
  local listed = {}
  local seen = {}
  for _, b in ipairs(bufnums) do
    if vim.fn.buflisted(b) == 1 and (not seen[b]) then
      listed[#listed + 1] = b
      seen[b] = true
    end
  end
  return listed
end

local function short_name(bufnum, limit)
  local name = vim.fn.fnamemodify(vim.fn.bufname(bufnum), ":t")
  if name == "" then name = "[No Name:" .. bufnum .. "]" end
  limit = limit or 18
  if #name > limit + 3 then name = string.sub(name, 1, limit) .. "..." end
  if vim.fn.getbufvar(bufnum, "&modified") == 1 then name = name .. " [+]" end
  return name
end

-- Build the tabline string
M.build = function()
  local s = "%#TabLineFill# "

  -- Left: Tabs (clickable via %nT and closable via %nX)
  local curr_tab = vim.api.nvim_get_current_tabpage()
  for _, tabid in ipairs(vim.api.nvim_list_tabpages()) do
    if not vim.api.nvim_tabpage_is_valid(tabid) then break end
    local tabnum = vim.api.nvim_tabpage_get_number(tabid)
    local wins = filter_float_wins(vim.api.nvim_tabpage_list_wins(tabid))

    s = s .. ((tabid == curr_tab) and "%#TabLineSel#" or "%#TabLine#")
    s = s .. " "
    -- clickable tab label using built-in %nT
    s = s .. "%" .. tabnum .. "T"
    s = s .. tabnum .. " "

    if #wins > 1 then
      s = s .. "[" .. #wins .. "]"
    end

    -- clickable close for tab: %nX closes tab n
    s = s .. "%" .. tabnum .. "X"
    s = s .. "×"

    s = s .. "%T" -- reset clickable region
    s = s .. " %#TabLineFill# "
  end

  -- Spacer
  s = s .. "%="

  -- Right: buffers in current tab (listed buffers only)
  s = s .. "%#TabLineSel# "
  local bufnums = filter_unlisted_buffers(vim.fn.tabpagebuflist(vim.api.nvim_tabpage_get_number(curr_tab)))
  for i, b in ipairs(bufnums) do
    local name = short_name(b, 20)
    local hl = (vim.fn.bufnr() == b) and "%#TabLineSel#" or "%#TabLine#"
    s = s .. hl .. " " .. name .. " "
  end

  -- Truncation point (truncate buffer names first)
  s = s .. "%<"
  return s
end

M.setup = function()
  -- set the tabline to call our Lua build function
  vim.go.tabline = "%!v:lua.require'ui.tabbar'.build()"

  -- sensible highlight defaults if colorscheme doesn't define them
  vim.cmd([[
    hi default TabLine guibg=NONE guifg=#888888
    hi default TabLineSel guibg=NONE guifg=#ffffff gui=bold
    hi default TabLineFill guibg=NONE guifg=#444444
  ]])

  -- Optional keymaps for buffer navigation (interactive via keyboard)
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- goto buffer number in current tab (1..9)
  for i = 1, 9 do
    map('n', '<leader>' .. tostring(i), function()
      local tab = vim.api.nvim_get_current_tabpage()
      local bufnums = filter_unlisted_buffers(vim.fn.tabpagebuflist(vim.api.nvim_tabpage_get_number(tab)))
      if bufnums[i] then
        vim.api.nvim_set_current_buf(bufnums[i])
      end
    end, opts)
  end

  -- buffer picker: choose from a list
  map('n', '<leader>bp', function()
    local tab = vim.api.nvim_get_current_tabpage()
    local bufnums = filter_unlisted_buffers(vim.fn.tabpagebuflist(vim.api.nvim_tabpage_get_number(tab)))
    local items = {}
    for _, b in ipairs(bufnums) do
      items[#items + 1] = short_name(b, 60)
    end
    local choice = vim.fn.inputlist(vim.list_extend({ 'Pick buffer:' }, items))
    if choice >= 1 and choice <= #bufnums then
      vim.api.nvim_set_current_buf(bufnums[choice])
    end
  end, opts)

  -- close buffer under cursor
  map('n', '<leader>bc', function()
    vim.cmd('bd')
  end, opts)
end

return M
