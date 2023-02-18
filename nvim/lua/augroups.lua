require("csharpaugroup")

local group = vim.api.nvim_create_augroup("All", {})
local diagnostics_group = vim.api.nvim_create_augroup("Diagnostics", {})
--vim.api.nvim_create_autocmd("BufWritePost", {
--	group = csGroup,
--	pattern = pattern,
--	callback = function () csFormat() end
--})
vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		pattern = "*",
		command = ":lua vim.lsp.buf.format()"
})

-- local vcentercursor = vim.api.nvim_create_augroup("VCenterCursor", {clear = true})
--
-- vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "WinNew", "VimResized"}, {
-- 	pattern = "*",
-- })

vim.api.nvim_exec([[
	augroup VCenterCursor
	au!
	au BufEnter,WinEnter,WinNew,VimResized *,*.* let &scrolloff=winheight(win_getid())
	augroup END
]], false)

vim.api.nvim_create_autocmd("CursorHold", {
		group = diagnostics_group,
		pattern = "*",
		command = ':lua vim.diagnostic.open_float({severety_sort=true,scope="cursor"})'
})
