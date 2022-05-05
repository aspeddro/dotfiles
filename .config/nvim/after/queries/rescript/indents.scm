; inherits: jsx

[
 (for_expression)
 (while_expression)
 (if_expression)
 (let_binding)
 ; (switch_expression)
 (expression_statement)
 (array)
 (call_expression)
 (list)
 (module_declaration)
  ; (block)
  ; (record)
] @indent

(record) @indent
(record (record_field) @indent)
(type_declaration (record_type) @indent)
(arguments (block) @indent) 

(variant) @indent

(variant_declaration) @auto

; ((variant_declaration) @aligned_indent
;   (#set! "delimiter" "|"))

(type_declaration) @auto
; (switch_match) @auto

(switch_expression) @auto

[
 "}"
 "]"
 ")"
] @indent_end

; (type_declaration) @dedent

[
 "("
 ")"
 "{"
 "}"
 "]"
 (else_clause)

 ; (variant_declaration)
 ; (block)
 ; (expression_statement)
] @branch

(record) @branch

; (block) @branch

; (variant_declaration) @branch
(arguments (block) @branch)

(ERROR) @auto
