(block
   (("{" @opening)
    ("}" @closing))) @container

(arguments
   (("(" @opening)
    (")" @closing))) @container

(formal_parameters
   (("(" @opening)
    (")" @closing))) @container

(array
   (("[" @opening)
    ("]" @closing))) @container

(array_pattern
   (("[" @opening)
    ("]" @closing))) @container

(tuple
   (("(" @opening)
    (")" @closing))) @container

(tuple_pattern
   (("(" @opening)
    (")" @closing))) @container

(template_substitution
  (("${" @opening)
   ("}"  @closing))) @container

; (type_parameters
;   (("<" @opening)
;    (">" @closing))) @container
