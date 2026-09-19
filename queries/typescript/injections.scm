; Inject SQL / XML highlighting into tagged template literals in TypeScript,
; e.g. `sql`...``, `db.sql`...``, `sql<number>`...`` and
; `sql<number>`...`.mapWith(fn).as('x')`.
;
; The tag name is used as the injection language, so the same pattern covers
; both `sql` and `xml`. `#offset!` trims the surrounding backticks before the
; template is handed to the injected parser.
;
; Three shapes are needed because tree-sitter-typescript splits explicit type
; arguments across different nodes depending on the type:
;
;   sql`...`                     -> call_expression
;   sql<string[]>`...`           -> call_expression > instantiation_expression
;   sql<number>`...`             -> binary_expression (`<`/`>` comparisons)
;
; The last one is tree-sitter-typescript#341: a type that is also a valid
; expression (`number`, `User`, ...) makes the grammar parse the type
; arguments as a comparison chain. There is no way to walk an arbitrary chain
; of trailing calls from that shape, so the method-call variants are listed
; explicitly.

; sql`...`, db.sql`...`, sql(`...`), db.sql(`...`)
(call_expression
  function: [
    (identifier) @injection.language
    (member_expression
      property: (property_identifier) @injection.language)
  ]
  arguments: [
    (template_string) @injection.content
    (arguments
      (template_string) @injection.content)
  ]
  (#any-of? @injection.language "sql" "xml")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))

; Type-only type arguments (`sql<string[]>`...``, `sql<{ id: number }>`...``)
; are parsed as an instantiation_expression rather than a comparison. Because
; the tag stays a normal call_expression here, trailing method chains need no
; special handling.
(call_expression
  function: (non_null_expression
    (instantiation_expression
      [
        (identifier) @injection.language
        (member_expression
          property: (property_identifier) @injection.language)
      ]
      (type_arguments)))
  arguments: (template_string) @injection.content
  (#any-of? @injection.language "sql" "xml")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))

; sql<number>`...`, db.sql<T>`...`.mapWith(fn).as('x'), etc.
(binary_expression
  left: (binary_expression
    left: [
      (identifier) @injection.language
      (member_expression
        property: (property_identifier) @injection.language)
    ]
    operator: "<")
  operator: ">"
  right: [
    (template_string) @injection.content
    (call_expression
      function: (member_expression
        object: (template_string) @injection.content))
    (call_expression
      function: (member_expression
        object: (call_expression
          function: (member_expression
            object: (template_string) @injection.content))))
    (call_expression
      function: (member_expression
        object: (call_expression
          function: (member_expression
            object: (call_expression
              function: (member_expression
                object: (template_string) @injection.content))))))
  ]
  (#any-of? @injection.language "sql" "xml")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))
