
((call_expression
  function: (identifier) @tag
  arguments: (template_string (#set! injection.language "sql")) @template)
 (#match? @tag "^sql$")
)
(call_expression
  function: (identifier) @injection.language (#eq? @injection.language "sql")
  arguments: (arguments (template_string (string_fragment (#set! injection.language "sql"))))
  )

((call_expression
  function: (identifier) @tag
  arguments: (template_string (#set! injection.language "xml")) @template)
 (#match? @tag "^xml$")
)
(call_expression
  function: (identifier) @injection.language (#eq? @injection.language "xml")
  arguments: (arguments (template_string (string_fragment (#set! injection.language "xml"))))
  )
