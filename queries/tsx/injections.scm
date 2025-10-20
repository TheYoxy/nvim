; Inject SQL highlighting for TSX tagged template literals:
;   sql`select * from dual`
; Keep this file at: ~/.config/nvim/queries/tsx/injections.scm

; sql`<span>`
(call_expression
  function: (identifier) @injection.language (#eq? @injection.language "sql")
  arguments: (arguments (template_string (string_fragment (#set! injection.language "sql"))))
  )
((call_expression
  function: (identifier) @tag
  arguments: (template_string) @template)
 (#match? @tag "^sql$")
 (#set! injection.language "sql"))
