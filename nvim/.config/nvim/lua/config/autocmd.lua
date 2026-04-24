local au = vim.api.nvim_create_augroup

au("general", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = "general",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = "general",
  callback = function()
    vim.opt_local.formatoptions:remove("r")
    vim.opt_local.formatoptions:remove("c")
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = "general",
  callback = function()
    vim.opt.switchbuf:append("useopen")
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  group = "general",
  callback = function()
    vim.cmd("silent! wall")
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = "general",
  callback = function()
    vim.cmd("wincmd =")
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = "general",
  callback = function()
    vim.cmd("checktime")
  end,
})

