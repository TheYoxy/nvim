;; extends
[
 (jsx_element)
 (jsx_self_closing_element)
] @tag.outer


(jsx_element
 (_ 
   (_) @tag.inner))

; (interface_declaration) @class.outer
; (interface_declaration
;  body: (interface_body
;    .
;    "{"
;    _+ @class.inner
;    "}"))
