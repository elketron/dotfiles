return function(split_command, no_new)
  if no_new == nil then
    no_new = false
  end

  -- If there's only one window, just create a new split
  if vim.fn.winnr("$") == 1 then
    vim.cmd(split_command)
    return
  end

  vim.cmd(":only")
  -- Create the new split
  if not no_new then
    vim.cmd(split_command)
  end
end
