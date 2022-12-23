
; ((dollar _ (identifier) @field))

; ((dollar (identifier) @variable.builtin)
;  (#eq? @variable.builtin "self"))

; (namespace_get function: (identifier) @variable)
; (namespace_get namespace: (identifier) @namespace)

; (call
;   (namespace_get function: (identifier) @function.call))
; (call
;   (namespace_get_internal function: (identifier) @function.call))
; (call
;   function: ((dollar _ (identifier) @method.call)))

; (call
;   function: (identifier) @function.builtin
;   (#lua-match? @function.builtin "return"))
