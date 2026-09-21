; Tailwind class-aware highlighting (POC).
;
; These patterns capture the string fragment that holds a class list and hand it
; to the custom `#tailwind!` directive, provided by lua/tailwind_classes:
;
;   @tailwind.classes -> the class list text
;   @_tailwind_ctx    -> the attribute / function name that owns that list
;
; The Lua side checks `_tailwind_ctx` against the configured attributes and
; functions (so `data-slot='...'` is ignored while `className=...` and `cn(...)`
; are not), then colours each token by its kind. This file only declares *where*
; class lists live; no grammar and no query for a new language are needed.

; className="px-1 py-2"
(jsx_attribute
  (property_identifier) @_tailwind_ctx
  (string (string_fragment) @tailwind.classes)
  (#tailwind! @tailwind.classes @_tailwind_ctx))

; className={'px-1 py-2'}
(jsx_attribute
  (property_identifier) @_tailwind_ctx
  (jsx_expression (string (string_fragment) @tailwind.classes))
  (#tailwind! @tailwind.classes @_tailwind_ctx))

; cn('px-1 py-2'), clsx('...'), cva('...'), classNames('...'), ...
(call_expression
  function: (identifier) @_tailwind_ctx
  arguments: (arguments (string (string_fragment) @tailwind.classes))
  (#tailwind! @tailwind.classes @_tailwind_ctx))
