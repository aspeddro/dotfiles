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
] @indent.begin


(try_expression (block) @indent.begin)

; (switch_expression) @auto

; (switch_match
;   body: (sequence_expression) @indent)

; (record (record_field) @indent)
; (arguments (block) @indent)
; (ternary_expression) @indent

; align indent a ? {} : {}
(ternary_expression
  consequence: ((block) @indent.align (#set! "delimiter" "{"))
  alternative: ((block) @indent.align (#set! "delimiter" "{")))




; (object_type "}" @indent_end)
; (record_type "}" @indent_end)
; (record "}" @indent_end)
; (block "}" @indent_end)
; (list "}" @indent_end)

[
  ")"
  "}"
  "]"
] @indent.branch
(block "{" @indent.branch)

[ "]" "}" ")" ] @indent.end

[
  (comment)
  (template_string)
] @indent.ignore

[
  (variant_declaration)
  (ERROR)
] @indent.auto


