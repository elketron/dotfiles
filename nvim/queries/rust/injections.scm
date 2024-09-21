;; extends

(
  (string_content) @injection.content
  (#match? @injection.content "SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete")
  (#set! injection.language "sql")
  (#set! "priority" 110) 
 )
