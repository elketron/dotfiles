local csGroup = vim.api.nvim_create_augroup("cs", {clear = true})
local pattern = "*.cs"

local csFormat = function (bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local file_name = vim.api.nvim_buf_get_name(bufnr)
	vim.api.nvim_exec(":silent ! dotnet format --include " .. vim.fn.expand("%:t"), false)
end


vim.api.nvim_create_autocmd("BufWritePost", {
	group = csGroup,
	pattern = pattern,
	callback = function () csFormat() end
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = csGroup,
	pattern = pattern,
	callback = function ()
		vim.api.nvim_buf_create_user_command(vim.api.nvim_get_current_buf(), "Csfile", function (nargs)		
			local filename = vim.split(nargs["args"], " ")
			local f = ""
			for i = 1, #filename do
				f = f .. filename[i]:gsub("^%l", string.upper)
			end

			vim.cmd(":e " .. f .. ".cs")
		end, {nargs = "*"})
	end
})

