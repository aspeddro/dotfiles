RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

P = function(v)
  print(vim.inspect(v))
  return v
end

R = function(name)
  return RELOAD(name)
end
