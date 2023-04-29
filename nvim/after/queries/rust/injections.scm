;; extends

((
  (raw_string_literal) @constant
  (#match? @constant "(SELECT|select|insert|INSERT|update|UPDATE|delete|DELETE|create|CREATE|alter|ALTER).*")
)@injection.content (#set! injection.language "sql"))

