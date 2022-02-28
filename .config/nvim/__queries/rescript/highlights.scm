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



; [
;  (formal_parameters
;   (tuple_pattern (value_identifier)))

;  (formal_parameters
;   (array_pattern (value_identifier)))

;  (positional_parameter (value_identifier))
; ] @parameter
