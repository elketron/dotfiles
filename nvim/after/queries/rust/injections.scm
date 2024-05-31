;; extends

((
  (raw_string_literal) @constant
  (#match? @constant "(SELECT|select|insert|INSERT|update|UPDATE|delete|DELETE|create|CREATE|alter|ALTER).*")
)@injection.content (#set! injection.language "sql"))

; macro invocation
(macro_invocation
  macro: (identifier) @ident (#eq? @ident "view")  
  (token_tree) @injection.content (#set! injection.language "html") (#set! injection.combined true)
)
