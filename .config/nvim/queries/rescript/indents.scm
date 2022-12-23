[
  (array)
  (call_expression)
  (list)
  (module_declaration)
  (block)
  (record)
  (object)
  (ternary_expression)
  ; (type_declaration)
  (formal_parameters)
  (variant)
  (variant_declaration)
  (function_type)
  (polyvar_type)
  (record_type)
] @indent

; (record) @indent
(record (record_field) @indent)
; (type_declaration) @indent
; (arguments (block) @indent)


; (ERROR (type_identifier)) @indent

; (function
;   body: (_) @_body
;   (#not-has-type? @_body block)
; ) @indent


[
  "("
  ")"
  "}"
  "{"
  "]"
  "["
] @branch

(block "{" @branch)

[
  "}"
  "]"
  ")"
] @indent_end

; [
;   (ERROR)
;   (switch_expression)
;   (type_declaration)
;   (binary_expression)
; ] @auto
