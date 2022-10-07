; inherits: jsx

[
  (array)
  (call_expression)
  (list)
  (module_declaration)
  (block)
  (record)
  (ternary_expression)
  ; (type_declaration)
  (formal_parameters)
  (variant)
  (variant_declaration)
  (function_type)
  (polyvar_type)
] @indent

; (record) @indent
(record (record_field) @indent)
; (type_declaration) @indent
; (arguments (block) @indent)


(ERROR (type_identifier)) @indent

; (formal_parameters) @indent


; (variant) @indent
; (variant_declaration) @auto

; (binary_expression) @auto

; ((variant_declaration) @aligned_indent
;   (#set! "delimiter" "|"))

; (type_declaration) @auto
; (switch_match) @indent


; (function_type) @indent
; (polyvar_type) @indent

(function
  body: (_) @_body
  (#not-has-type? @_body block)
) @indent

; (switch_match
;   body: (_) @_body
;   (#not-has-type? @_body statement_block)
; ) @indent

; (let_binding
;   (function)) @indent
; (switch_expression) @auto

; (function body: (block)) @indent

[
  ; "("
  ")"
  ; "}"
  "]"
  ; (else_clause)
  ; (else_if_clause)
  (record)
] @branch

(block "{" @branch)

[
  "}"
  "]"
  ")"
] @indent_end

[
  (ERROR)
  (switch_expression)
  (type_declaration)
  (binary_expression)
] @auto
