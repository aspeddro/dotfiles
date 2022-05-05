(comment) @comment

; Identifiers
;------------
(value_identifier) @variable

; Escaped identifiers like \"+."
((value_identifier) @constant.macro
 (#match? @constant.macro "^\\.*$"))

[
  (type_identifier)
  "list"
] @type

((type_identifier) @type.builtin
 (#any-of? @type.builtin
  "int" "float" "string" "bool" "array"))

(unit_type) @type.builtin

(unit ["(" ")"]) @type.builtin

[
  (variant_identifier)
  (polyvar_identifier)
] @constant

(record_type_field (property_identifier) @property)
(record_field (property_identifier) @property)
(object (field (property_identifier) @property))
(object_type (field (property_identifier) @property))
(member_expression (property_identifier) @property)
(module_identifier) @namespace

; Parameters
;----------------

(list_pattern (value_identifier) @parameter)
(spread_pattern (value_identifier) @parameter)
(formal_parameters (value_identifier) @parameter)

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
(polyvar) @constant
(polyvar_string) @constant

; Functions
;----------
(call_expression
  function: (value_identifier) @function)

[
 (formal_parameters (value_identifier))
 (labeled_parameter (value_identifier))
] @parameter

(function parameter: (value_identifier) @parameter)
(labeled_argument
  label: (value_identifier) @parameter)

(labeled_parameter (value_identifier) @parameter)

(call_expression
  function: (pipe_expression (_) (value_identifier) @function))
(call_expression
  function: (pipe_expression (_) (value_identifier_path (value_identifier) @function)))


(call_expression
  function: (value_identifier_path (value_identifier) @function))
; Meta
;-----

[
 "@"
 "@@"
 (decorator_identifier)
] @annotation

(extension_identifier) @keyword
("%") @keyword

; Misc
;-----

(subscript_expression index: (string) @property)
(polyvar_type_pattern "#" @constant)

[
  ("include")
  ("open")
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
] @keyword

[
  "if"
  "else"
  "switch"
] @conditional

[
  "exception"
  "try"
  "catch"
  "raise"
] @exception

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
] @punctuation.delimiter

[
  "++"
  "+"
  "+."
  "-"
  "-."
  "*"
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
