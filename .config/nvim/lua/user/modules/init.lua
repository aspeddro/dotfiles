return setmetatable({}, {
  __index = function(t, k)
    local ok, builtin = pcall(require, string.format('user.modules.%s', k))

    if ok then
      rawset(t, k, builtin)
    end

    return builtin
  end,
})
