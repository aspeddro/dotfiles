("$" (identifier) @field)

(call
  function: (identifier) @keyword.return
  (#lua-match? @keyword.return "return"))
