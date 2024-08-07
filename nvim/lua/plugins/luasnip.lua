return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local types = require("luasnip.util.types")
      local cmp = require("cmp")

      luasnip.config.set_config({
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
              virt_text = { { "●", "rainbowcol1" } },
              priority = 1,
            },
          },
          [types.insertNode] = {
            active = {
              virt_text = { { "●", "rainbowcol5" } },
            },
          },
        },
        ext_base_prio = 200,
        ext_prio_increase = 2,
      })

      vim.keymap.set("i", "<A-l>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end)

      vim.keymap.set("i", "<A-u>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(-1)
        end
      end)

      vim.keymap.set("s", "<A-l>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end)

      vim.keymap.set("s", "<A-u>", function()
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

      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

      local current_nsid = vim.api.nvim_create_namespace("LuaSnipChoiceListSelections")
      local current_win = nil

      local function window_for_choiceNode(choiceNode)
        local buf = vim.api.nvim_create_buf(false, true)
        local buf_text = {}
        local row_selection = 0
        local row_offset = 0
        local text
        for _, node in ipairs(choiceNode.choices) do
          text = node:get_docstring()
          -- find one that is currently showing
          if node == choiceNode.active_choice then
            -- current line is starter from buffer list which is length usually
            row_selection = #buf_text
            -- finding how many lines total within a choice selection
            row_offset = #text
          end
          vim.list_extend(buf_text, text)
        end

        vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, buf_text)
        local w, h = vim.lsp.util._make_floating_popup_size(buf_text)

        -- adding highlight so we can see which one is been selected.
        local extmark = vim.api.nvim_buf_set_extmark(
          buf,
          current_nsid,
          row_selection,
          0,
          { hl_group = "incsearch", end_line = row_selection + row_offset }
        )

        -- shows window at a beginning of choiceNode.
        local win = vim.api.nvim_open_win(buf, false, {
          relative = "win",
          width = w,
          height = h,
          bufpos = choiceNode.mark:pos_begin_end(),
          style = "minimal",
          border = "rounded",
        })

        -- return with 3 main important so we can use them again
        return { win_id = win, extmark = extmark, buf = buf }
      end

      function choice_popup(choiceNode)
        -- build stack for nested choiceNodes.
        if current_win then
          vim.api.nvim_win_close(current_win.win_id, true)
          vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
        end
        local create_win = window_for_choiceNode(choiceNode)
        current_win = {
          win_id = create_win.win_id,
          prev = current_win,
          node = choiceNode,
          extmark = create_win.extmark,
          buf = create_win.buf,
        }
      end

      function update_choice_popup(choiceNode)
        vim.api.nvim_win_close(current_win.win_id, true)
        vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
        local create_win = window_for_choiceNode(choiceNode)
        current_win.win_id = create_win.win_id
        current_win.extmark = create_win.extmark
        current_win.buf = create_win.buf
      end

      function choice_popup_close()
        vim.api.nvim_win_close(current_win.win_id, true)
        vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
        -- now we are checking if we still have previous choice we were in after exit nested choice
        current_win = current_win.prev
        if current_win then
          -- reopen window further down in the stack.
          local create_win = window_for_choiceNode(current_win.node)
          current_win.win_id = create_win.win_id
          current_win.extmark = create_win.extmark
          current_win.buf = create_win.buf
        end
      end

      vim.cmd([[
augroup choice_popup
au!
au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
au User LuasnipChoiceNodeLeave lua choice_popup_close()
au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
augroup END
]])
    end,
  },
}
