; (extension_expression
;   (extension_identifier) @_name
;   (#match? @_name "^styled|cx")
;   (expression_statement (template_string) @css
;   (#offset! @css 0 1 0 -1)))

; (extension_expression
;   (extension_identifier) @_name
;   (#eq? @_name "css")
;   (expression_statement (string (string_fragment) @css)))
