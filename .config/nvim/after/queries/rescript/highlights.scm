;; New hightlights
(value_identifier_path (value_identifier) @method)
(call_expression
 function: (value_identifier) @function)

(pipe_expression
 (value_identifier)
 (value_identifier) @function)

(pipe_expression
  (value_identifier) @function)

(let_binding
 (value_identifier) @function
 (function))

[
  (variant_type) "|"
] @punctuation.special

(character) @string.special

[
  (true)
  (false)
] @boolean

; (type_parameters (type_identifier) @parameter)
; (generic_type (type_arguments (type_identifier) @parameter))

; ((type_identifier) @type
;   (#match? @type "(int|float)")) @type.builtin

; ((type_identifier) @type
;  (#lua-match? @type "(int|float)"))

(function
  parameters: (formal_parameters (tuple_pattern (tuple_item_pattern (value_identifier) @parameter))))

(function
  parameters: (formal_parameters (array_pattern  (value_identifier) @parameter))) 


(labeled_argument
  label: (value_identifier) @parameter)


(type_declaration (type_parameters (type_identifier) @parameter ))

(variant_declaration (variant_parameters (type_identifier) @parameter))

(generic_type (type_arguments (type_identifier) @parameter ))



((type_identifier) @type.builtin
 (#any-of? @type.builtin
  "int" "float" "string" "bool" "array" "unit"))

(unit_type) @type.builtin

; (formal_parameters
; (array_pattern (value_identifier) @parameter))

 ; (positional_parameter (value_identifier))

(ERROR) @error
