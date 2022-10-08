local ls = require 'luasnip'
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  date = {
    f(function()
      return string.format(
        string.gsub(vim.bo.commentstring, '%%s', ' %%s'),
        os.date()
      )
    end, {}),
  },
  todo = f(function()
    return string.format(
      string.gsub(vim.bo.commentstring, '%%s', '%%s'),
      ' TODO: '
    )
  end),
  hashbang = fmt([[{}!/usr/bin/{} {}]], { i(1), i(2, 'env'), i(3) }),
}
