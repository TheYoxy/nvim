; Tailwind class-aware highlighting for plain TypeScript (no JSX nodes here, see
; queries/tsx/highlights.scm for the JSX attributes).
;
; Only the class-function form is valid for the `typescript` grammar:
;
;   cn('px-1 py-2'), clsx('...'), cva('...'), classNames('...'), ...
;
; The `#tailwind!` directive is provided by lua/tailwind_classes.

(call_expression
  function: (identifier) @_tailwind_ctx
  arguments: (arguments (string (string_fragment) @tailwind.classes))
  (#tailwind! @tailwind.classes @_tailwind_ctx))
