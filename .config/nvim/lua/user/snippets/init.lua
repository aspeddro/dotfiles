local ls = require 'luasnip'
local snippet = ls.s
local t = ls.text_node
local i = ls.insert_node

local M = {}

local shortcut = function(val)
  if type(val) == 'string' then
    return { t { val }, i(0) }
  end

  if type(val) == 'table' then
    for k, v in ipairs(val) do
      if type(v) == 'string' then
        val[k] = t { v }
      end
    end
  end

  return val
end

M.make = function(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    table.insert(result, (snippet({ trig = k, desc = v.desc }, shortcut(v))))
  end

  return result
end

--- Utils nodes
M.shared = {
  newline = function(text)
    return t { '', text }
  end,
}

M.filetype = {}
setmetatable(M.filetype, {
  __index = function(_, k)
    local ok, my_snippets = pcall(require, string.format('user.snippets.%s', k))

    if not ok then
      vim.notify('Snippets not found for ' .. k)
      return
    end

    return M.make(my_snippets)
  end,
})

return M
