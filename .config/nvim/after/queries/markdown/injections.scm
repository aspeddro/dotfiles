; pandoc latex command
; ((paragraph) @latex
;  (#lua-match? @latex "^\\"))

; pandoc equation
; ((paragraph) @latex
;  (#lua-match? @latex "^\$\$[a-zA-Z]+\$\$"))

; pandoc inline equation
; ((paragraph) @latex
;  (#lua-match? @latex "\$(.*)\$"))
