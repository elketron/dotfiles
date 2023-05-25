local s = require("luasnip.nodes.snippet").S
local sn = require("luasnip.nodes.snippet").SN
local isn = require("luasnip.nodes.snippet").ISN
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I
local f = require("luasnip.nodes.functionNode").F
local c = require("luasnip.nodes.choiceNode").C
local d = require("luasnip.nodes.dynamicNode").D
local r = require("luasnip.nodes.restoreNode").R
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local matches = require("luasnip.extras.postfix").matches
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

local varTypes = {
  list = { vars = 1, node = t("list") },
  dictionary = { vars = 2, t("dictionary") }
}

local function choiceAccessModifiers(jump_index)
  return c(jump_index, {
    t "",
    t "public",
    t "private",
    t "protected",
    t "internal",
    t "protected internal",
    t "private protected"
  })
end

local function textToUpper(textarr)
  local text = ""
  for j = 1, #textarr do
    text = text .. textarr[j]:gsub("^%l", string.upper)
  end
  return text
end

local function partialProperty(type, var)
  return sn(nil, {
    i(1),
    choiceAccessModifiers(2),
    t(" " .. type .. " " .. var .. " {get; set;}")
  })
end

local function fullProperty(type, var_private, var_public)
  return t({
    " private " .. type .. " " .. var_private .. ";",
    " public " .. type .. " " .. var_public,
    " {",
    "   get { return " .. var_private .. "; }",
    "   set { " .. var_private .. " = value; }",
    " }"
  })
end

local function propsNode(parent)
  local match = parent.snippet.env.POSTFIX_MATCH:match '^%s*(.*)'
  local args_table = vim.split(match, " ")
  local type = args_table[1]
  local var_public = textToUpper({ unpack(args_table, 2, #args_table) })
  local var_private = table.concat(args_table, "", 2, #args_table)

  return sn(nil, {
    c(1, {
      partialProperty(type, var_public),
      fullProperty(type, var_private, var_public)
    })
  }, {})
end

local function variablesNodes(parent)
  local match = parent.snippet.env.POSTFIX_MATCH:match '^%s*(.*)'
  local args_table = vim.split(match, " ")
  local var_name = textToUpper({ unpack(args_table, 1, #args_table) })
  return sn(nil, {
    c(1, {
      sn(nil, { i(1, "int"), t(" " .. var_name .. " ="), i(0) }),
      sn(nil, { i(1, "int"), t("[] " .. var_name .. " = "), i(2) }),
      sn(nil, { t("List<"), i(1, "int"), t("> " .. var_name .. " = new List<"), rep(1), t(">") })
    })
  }, {})
end

local function getFileName()
  local file = vim.api.nvim_buf_get_name(0)
  file = vim.split(file:match("^.+/(.+)$"), "%.")[1]
  return file
end

-- define snippets in return statement
return {
  s("cw", fmt([[Console.WriteLine(<>)<>]], { i(1), i(0) }, { delimiters = "<>" })),
  s("class", fmt([[
        class <> <>
        {
          <>
        }
      ]], {
      p(getFileName),
      c(1, {
        t(""),
        sn(nil, { t(": "), i(1) })
      }),
      i(0) }, { delimiters = "<>"
    }),
    {}),
  s("interface", fmt([[
      interface <>
      {
        <>
      }
    ]], { p(getFileName), i(0) }, { delimiters = "<>" }), {}),
  postfix({ match_pattern = "^.+$", trig = ".prop" }, {
    d(1, function(_, parent)
      return propsNode(parent)
    end)
  }),
  postfix({ match_pattern = "^.+$", trig = ".var" }, {
    d(1, function(_, parent)
      return variablesNodes(parent)
    end)
  }),
  s("con", fmt([[
      using Microsoft.AspNetCore.MVC;

      [Route("<>")]
      [ApiController]
      class <> : ControllerBase
      {
        <>
      }
      ]], {
      i(1, "/api/controller"),
      p(getFileName),
      i(0) }, { delimiters = "<>"
    }),
    {}),
  s("act", fmt([[
    [<>]
    public ActionResult <> (<>)
    {
      <>
    }
  ]], { c(1, {
    t("HttpGet"),
    t("HttpPost"),
    t("HttpDelete"),
    t("HttpPut"),
    t("HttpPatch")
  }), i(2, "Action"), i(3), i(0)
  }, { delimiters = "<>" }))

}
