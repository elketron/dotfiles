local ts_query = require("nvim-treesitter.query")

local lang = "c_sharp"

local query = [[(file_scoped_namespace_declaration
  (class_declaration
    body: (declaration_list
      (method_declaration
        (modifier) @modifier
        (#match? @modifier "public")
        name:(identifier) @name
      )
    )
  )
)]]

local function GetRoutes()
  local cwd = vim.api.nvim_buf_get_name(0)
  print(cwd)
  local table_dir = vim.split(cwd, "/", {})
  local file_name = table_dir[#table_dir - 1] .. "Controller.cs"
  print(file_name)

  --return matches
end

local function GenRoutesAsChoice()
  local routes = GetRoutes()

  local routes_table = {}
  for route in routes do
    table.insert(routes_table, t(route[1]))
  end

  return {} --routes_table
end

return {
  s("roa", {
    d(1, GenRoutesAsChoice),
  }),
}
