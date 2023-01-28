; inherits: jsx

[
  ; (for_expression)
  ; (while_expression)
  (if_expression)
  (let_binding)
  ; (switch_expression)
  (expression_statement)
  (array)
  (call_expression)
  (list)
  (module_declaration)
  (record)
  (variant)
  ; (block)
  (type_declaration)
  (ternary_expression)
] @indent


(try_expression (block) @indent)

; (switch_expression) @auto

; (switch_match
;   body: (sequence_expression) @indent)

; (record (record_field) @indent)
; (arguments (block) @indent)
; (ternary_expression) @indent

; align indent a ? {} : {}
(ternary_expression
  consequence: ((block) @aligned_indent (#set! "delimiter" "{"))
  alternative: ((block) @aligned_indent (#set! "delimiter" "{")))




; (object_type "}" @indent_end)
; (record_type "}" @indent_end)
; (record "}" @indent_end)
; (block "}" @indent_end)
; (list "}" @indent_end)

[
  ")"
  "}"
  "]"
] @branch
(block "{" @branch)

[ "]" "}" ")" ] @indent_end

[
  (comment)
  (template_string)
] @ignore

[
  (variant_declaration)
  (ERROR)
] @auto


