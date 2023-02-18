local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local types = require("luasnip.util.types")
local cmp = require("cmp")

luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    --[types.choiceNode] = {
    --  active ={
    --    virt_text = {{"<=", "Error"}},
    --  }
    --},
		[types.choiceNode] = {
			active = {
				virt_text = {{"●", "SrceryRed"}},
        priority = 1
			}
		},
		[types.insertNode] = {
			active = {
				virt_text = {{"●", "SrceryBlue"}}
			}
		}
  },
  ext_base_prio = 200,
	ext_prio_increase = 2,
}

vim.keymap.set("i", "<A-l>", function ()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

vim.keymap.set("i", "<A-u>", function ()
  if luasnip.choice_active() then
    luasnip.change_choice(-1)
  end
end)

vim.keymap.set("s", "<A-l>", function ()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

vim.keymap.set("s", "<A-u>", function ()
  if luasnip.choice_active() then
    luasnip.change_choice(-1)
  end
end)


-- vim.keymap.set({"i", "s"}, "<a-n>", function ()
--   if luasnip.expand_or_jumpable() then
--     luasnip.expand_or_jump()
--   end
-- end)

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/_luasnip.lua<CR>")

cmp.setup({
  mapping = {
    ["<A-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
      -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<A-e>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

})

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/"})
