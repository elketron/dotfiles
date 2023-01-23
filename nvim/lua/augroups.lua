require("csharpaugroup")

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



