; (comment) @comment

; (extension_expression
;   (extension_identifier) @_name
;   (#match? @_name "^styled|cx")
;   (expression_statement (template_string) @css
;   (#offset! @css 0 1 0 -1)))

; (extension_expression
;   (extension_identifier) @_name
;   (#eq? @_name "css")
;   (expression_statement (string (string_fragment) @css)))

(raw_js) @javascript

(extension_expression
  (extension_identifier) @_name
  (#eq? @_name "re")
  (expression_statement (string ((string_fragment) @regex))))

(raw_gql) @graphql


; ((((comment) @_line (#lua-match? @_line "^///")) @combined) @markdown)
; ((comment) @_line
;   (#lua-match? @_line "^/**"))

; (((comment) @_doc_comment
;   (#match? @_doc_comment "^/\\*\\*")) @markdown
;   (#offset! @markdown 0 3 0 -3))
