(comment) @comment

; %re
(extension_expression
  (extension_identifier) @_name
  (#eq? @_name "re")
  (expression_statement (_) @regex))

; %raw
(extension_expression
  (extension_identifier) @_name
  (#eq? @_name "raw")
  (expression_statement
    (_ (_) @javascript)))

; %graphql
(extension_expression
  (extension_identifier) @_name
  (#eq? @_name "graphql")
  (expression_statement
    (_ (_) @graphql)))

; (((comment) @_doc_comment
;   (#match? @_doc_comment "^/\\*\\*")) @markdown
;   (#offset! @markdown 0 3 0 -3))
