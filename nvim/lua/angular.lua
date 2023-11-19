local ng = require("ng")

vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, opts)
vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, opts)
vim.keymap.set("n", "<leader>aT", ng.get_template_tcb, opts)

function _G.userCommandCompletion(lead, line, cmdIndex)
  local values = {}
  for value in line:gmatch("%S+") do
    table.insert(values, value)
  end

  if #values > 1 then
    return {}
  end

  local commands = {
    "service",
    "component",
    "directive",
    "pipe",
    "module",
    "class",
    "guard",
    "interface",
    "enum",
    "lib",
  }

  local matches = {}
  for _, command in ipairs(commands) do
    if command:find(lead) then
      table.insert(matches, command)
    end
  end

  return matches
end

local group = vim.api.nvim_create_augroup("Angular", {})

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = "*ts, *html,*css",
  callback = function()
    vim.api.nvim_create_user_command("Ng", function(args)
        local cmd = "ng generate " .. args.args
        vim.cmd("!" .. cmd)
      end,
      {
        nargs = "*",
        complete = "customlist,v:lua.userCommandCompletion",
        bang = true,
      })
  end
})
