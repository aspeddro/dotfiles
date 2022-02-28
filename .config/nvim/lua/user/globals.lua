-- from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/globals.lua
P = function(v)
  if type(v) ~= 'table' then
    print(v)
    return v
  else
    print(vim.inspect(v))
    return v
  end
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

-- FN = setmetatable({}, {
--   __index = function(t, key)
--     local function _fn(...)
--       return vim.api.nvim_call_function(key, { ... })
--     end
--     t[key] = _fn
--     return _fn
--   end,
-- })

-- T = function()
--   local langtree = vim.treesitter.get_parser(0)
--   local cursor = vim.api.nvim_win_get_cursor(0)
--   local current_tree = langtree:language_for_range {
--     cursor[1],
--     cursor[2],
--     cursor[1],
--     cursor[2],
--   }
--   return current_tree:lang()
-- end
