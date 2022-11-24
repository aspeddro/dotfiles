(comment) @comment

; Identifiers
;------------
(value_identifier) @variable

; Escaped identifiers like \"+."
; ((value_identifier) @constant.macro
;  (#match? @constant.macro "^\\.*$"))

(type_identifier) @type

(list "list{" @function.builtin)
(list_pattern "list{" @function.builtin)
; To ensure that the closing curly bracket is the same color (scope) as the opening curly bracket
(list "}" @function.builtin (#set! "priority" 105))
(list_pattern "}" @function.builtin (#set! "priority" 105))

((type_identifier) @type.builtin
 (#any-of? @type.builtin
  "int" "float" "string" "bool" "array" "list" "promise"))

(unit_type) @type.builtin

(unit ["(" ")"]) @type.builtin

[
  (variant_identifier)
  (polyvar_identifier)
] @constructor

; (record_type_field (property_identifier) @property)
; (record_field (property_identifier) @property)
; (object (field (property_identifier) @property))
; (object_type (field (property_identifier) @property))
; (member_expression (property_identifier) @property)

(_ (property_identifier) @property)
(_ (property_identifier (_) (value_identifier) @property))

(module_identifier) @namespace

; Parameters
;----------------

(parameter (value_identifier) @parameter)
(labeled_parameter (value_identifier) @parameter)
(function parameter: (value_identifier) @parameter)

; (list_pattern (value_identifier) @parameter)
; (spread_pattern (value_identifier) @parameter)
; (formal_parameters (value_identifier) @parameter)

; String literals
;----------------

[
  (string)
  (template_string)
] @string

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special)

(character) @character
(escape_sequence) @string.escape

; Other literals
;---------------

[
  (true)
  (false)
] @boolean

(number) @number

; Functions
;----------

(call_expression
  function: (value_identifier) @function.call)

(call_expression
  function: (value_identifier_path (value_identifier) @function.call))

(call_expression
  function: (_ (property_identifier) @function.call))

; (binary_expression
;   operator: ["->" "|>"]
;   right: (value_identifier) @function)

; (pipe_expression (_) (value_identifier) @function)

; (pipe_expression (_) (_ (value_identifier) @function))

; (function parameter: (value_identifier) @parameter)
; (labeled_argument
;   label: (value_identifier) @parameter)

; (labeled_parameter (value_identifier) @parameter)


; Meta
;-----

[
 "@"
 "@@"
 (decorator_identifier)
] @attribute


[
  "%"
  (extension_identifier)
] @prepoc


; Misc
;-----

; (subscript_expression index: (string) @property)
(polyvar_type_pattern "#" @constructor)

[
  "include"
  "open"
] @include

[
  "as"
  "export"
  "external"
  "let"
  "module"
  "of"
  "mutable"
  "private"
  "rec"
  "type"
  "and"
  "assert"
  "await"
  "with"
  "unpack"
  "module"
  "lazy"
  "constraint"
] @keyword

((function "async" @keyword))

[
  "if"
  "else"
  "switch"
  "when"
] @conditional

[
  "exception"
  "try"
  "catch"
] @exception

(call_expression
  function: (value_identifier) @exception
  (#eq? @exception "raise"))

[
  "for"
  "in"
  "to"
  "downto"
  "while"
] @repeat

[
  "."
  ","
  "|"
  ";"
] @punctuation.delimiter

[
  "++"
  "+"
  "+."
  "-"
  "-."
  "*"
  "**"
  "*."
  "/."
  "<="
  "=="
  "==="
  "!"
  "!="
  "!=="
  ">="
  "&&"
  "||"
  "="
  ":="
  "->"
  "|>"
  ":>"
  (uncurry)
] @operator

; Explicitly enclose these operators with binary_expression
; to avoid confusion with JSX tag delimiters
(binary_expression ["<" ">" "/"] @operator)

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

(polyvar_type
  [
   "["
   "[>"
   "[<"
   "]"
  ] @punctuation.bracket)

[
  "~"
  "?"
  "=>"
  "..."
] @punctuation.special

(ternary_expression ["?" ":"] @operator)

; JSX
;----------
(jsx_identifier) @tag
(jsx_element
  open_tag: (jsx_opening_element ["<" ">"] @tag.delimiter))
(jsx_element
  close_tag: (jsx_closing_element ["<" "/" ">"] @tag.delimiter))
(jsx_self_closing_element ["/" ">" "<"] @tag.delimiter)
(jsx_fragment [">" "<" "/"] @tag.delimiter)
(jsx_attribute (property_identifier) @tag.attribute)

; Error
;----------

(ERROR) @error
