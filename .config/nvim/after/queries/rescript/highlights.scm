;; extends

[(list) (list_pattern)] @function.builtin

((type_identifier) @type.builtin
 (#any-of? @type.builtin
  "int" "float" "string" "bool" "array" "list" "promise"))

(let_binding
  (value_identifier) @function
  (function))

(call_expression
  function: (value_identifier) @function.call)

(call_expression
  function: (value_identifier_path (value_identifier) @function.call))

(call_expression
  function: (_ (property_identifier) @function.call))

(pipe_expression (_) (value_identifier) @function.call)
; Match x->Mod.f
(pipe_expression (_) (_ (value_identifier) @function.call))

((value_identifier) @variable.builtin
 (#any-of? @variable.builtin "__FILE__" "__LINE__" "__LINE_OF__" "__LOC__" "__LOC_OF__" "__MODULE__" "__POS__" "__POS_OF__"))
