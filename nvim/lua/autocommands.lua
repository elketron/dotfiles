local diagnostics_group = vim.api.nvim_create_augroup("Diagnostics", {})

vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })

vim.api.nvim_create_autocmd("CursorHold", {
  group = diagnostics_group,
  pattern = "*",
  command = ':lua vim.diagnostic.open_float({severety_sort=true,scope="cursor"})',
})

local center_group = vim.api.nvim_create_augroup("VCenterCursor", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "WinNew", "VimResized" }, {
  group = center_group,
  pattern = { "*", "*.*" },
  callback = function()
    vim.opt.scrolloff = vim.api.nvim_win_get_height(0)
  end,
})
