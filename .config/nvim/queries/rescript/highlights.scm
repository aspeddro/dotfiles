(comment) @comment

; Identifiers
;------------
(value_identifier) @variable

; Escaped identifiers like \"+."
((value_identifier) @constant.macro
 (#match? @constant.macro "^\\.*$"))

[
  (type_identifier)
  (list)
  (list_pattern)
] @type

[
  (unit_type)
  (unit)
] @type.builtin

[
  (variant_identifier)
  (polyvar_identifier)
] @constructor

(polyvar_type_pattern "#" @constructor)

(record_type_field (property_identifier) @property)
(record_field (property_identifier) @property)
(record_field (property_identifier (_) (value_identifier) @property))
(object (field (property_identifier) @property))
(object_type (field (property_identifier) @property))
(member_expression (property_identifier) @property)
(module_identifier) @namespace

; Parameters
;----------------

; (list_pattern (value_identifier) @parameter)
; (spread_pattern (value_identifier) @parameter)

; String literals
;----------------

[
  (string)
  (template_string)
] @string

(template_substitution
  "${" @punctuation.bracket
  "}" @punctuation.bracket) @embedded

(character) @string.special
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

; parameter(s) in parens
; [
;  (parameter (value_identifier))
;  (labeled_parameter (value_identifier))
;  ; single parameter with no parens
;  (function parameter: (value_identifier))
; ] @parameter

(parameter (value_identifier) @parameter)
(labeled_parameter (value_identifier) @parameter)

; single parameter with no parens
(function parameter: (value_identifier) @parameter)

; first-level descructuring (required for nvim-tree-sitter as it only matches direct
; children and the above patterns do not match destructuring patterns in NeoVim)
(parameter (tuple_pattern (tuple_item_pattern (value_identifier) @parameter)))
(parameter (array_pattern (value_identifier) @parameter))
(parameter (record_pattern (value_identifier) @parameter))

; Meta
;-----

; (decorator "@" @attribute)
(decorator_identifier) @attribute


[
  "%"
  (extension_identifier)
] @prepoc

; Misc
;-----

(subscript_expression index: (string) @property)

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
  "mutable"
  "private"
  "rec"
  "type"
  "and"
  "assert"
  "await"
  "with"
  "lazy"
  "constraint"
  "of"
] @keyword

((function "async" @keyword))

(module_unpack "unpack" @keyword)

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
  "+="
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
  ".."
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
