;; New hightlights

; (value_identifier) @variable

; (value_identifier_path (value_identifier) @method)
; (call_expression
;  function: (value_identifier) @function)

; (pipe_expression
;  (value_identifier)
;  (value_identifier) @function)

; (pipe_expression
;   (value_identifier) @function)

; (let_binding
;  (value_identifier) @function
;  (function))

; [
;   "|"
; ] @punctuation.special

; (character) @character

; [
;   (true)
;   (false)
; ] @boolean

; (type_parameters (type_identifier) @parameter)
; (generic_type (type_arguments (type_identifier) @parameter))

; ((type_identifier) @type
;   (#match? @type "(int|float)")) @type.builtin

; ((type_identifier) @type
;  (#lua-match? @type "(int|float)"))

; (function
;   parameters: (formal_parameters (tuple_pattern (tuple_item_pattern (value_identifier) @parameter))))

; (function
;   parameters: (formal_parameters (array_pattern  (value_identifier) @parameter))) 


; (labeled_argument
;   label: (value_identifier) @parameter)


; (type_declaration (type_parameters (type_identifier) @variable))

; (variant_declaration (variant_parameters (type_identifier) @variable))

; (generic_type (type_arguments (type_identifier) @variable))



; ((type_identifier) @type.builtin
;  (#any-of? @type.builtin
;   "int" "float" "string" "bool" "array"))

; (unit_type) @type.builtin

[ "list" ] @function

; TODO:
; (unit ["(" ")"]) @type.builtin


; (formal_parameters
; (array_pattern (value_identifier) @parameter))

 ; (positional_parameter (value_identifier))


; (jsx_opening_element
;   name: (jsx_identifier) @tag)

; (jsx_closing_element
;   name: (jsx_identifier) @tag)

; (jsx_self_closing_element
;   name: (jsx_identifier) @tag)

; (jsx_opening_element ((jsx_identifier) @constructor
;  (#lua-match? @constructor "^[A-Z]")))

; Handle the dot operator effectively - <My.Component>
; (jsx_opening_element ((nested_jsx_identifier (jsx_identifier) @tag (jsx_identifier) @constructor)))

; (jsx_closing_element ((jsx_identifier) @constructor
;  (#lua-match? @constructor "^[A-Z]")))

; Handle the dot operator effectively - </My.Component>
; (jsx_closing_element ((nested_jsx_identifier (jsx_identifier) @tag (jsx_identifier) @constructor)))

; (jsx_self_closing_element ((jsx_identifier) @constructor
;  (#lua-match? @constructor "^[A-Z]")))

; Handle the dot operator effectively - <My.Component />
; (jsx_self_closing_element ((nested_jsx_identifier (jsx_identifier) @tag (jsx_identifier) @constructor)))
