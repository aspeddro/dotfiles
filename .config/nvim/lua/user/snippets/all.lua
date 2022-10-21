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
      'TODO: '
    )
  end),
  hashbang = fmt([[{}!/usr/bin/{} {}]], { i(1), i(2, 'env'), i(3) }),
  loremsen = [[Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.]],
  lorempa = [[Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet. Nisi anim cupidatat excepteur officia. Reprehenderit nostrud nostrud ipsum Lorem est aliquip amet voluptate voluptate dolor minim nulla est proident. Nostrud officia pariatur ut officia. Sit irure elit esse ea nulla sunt ex occaecat reprehenderit commodo officia dolor Lorem duis laboris cupidatat officia voluptate. Culpa proident adipisicing id nulla nisi laboris ex in Lorem sunt duis officia eiusmod. Aliqua reprehenderit commodo ex non excepteur duis sunt velit enim. Voluptate laboris sint cupidatat ullamco ut ea consectetur et est culpa et culpa duis.]],
}
