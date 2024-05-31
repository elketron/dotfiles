-- global function for snippets

 ls = require'luasnip'
 s = ls.s
 sn = ls.sn
 t = ls.t
 i = ls.i
 f = ls.f
 c = ls.c
 d = ls.d

 function copy(args)
	return args[1]
end

 function char_count_same(c1, c2)
	 line = vim.api.nvim_get_current_line()
	 _, ct1 = string.gsub(line, c1, '')
	 _, ct2 = string.gsub(line, c2, '')
	return ct1 == ct2
end

 function even_count(c)
	 line = vim.api.nvim_get_current_line()
	 _, ct = string.gsub(line, c, '')
	return ct % 2 == 0
end

 function neg(fn, ...)
	return not fn(...)
end

