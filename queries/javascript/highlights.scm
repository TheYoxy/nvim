; Tailwind class-aware highlighting (POC) for JavaScript / JSX.
; See queries/tsx/highlights.scm for the TypeScript version.
;
; The `#tailwind!` directive is provided by lua/tailwind_classes.

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
