(file_scoped_namespace_declaration
  (class_declaration
    body: (declaration_list
      (method_declaration
        (modifier) @modifier
        (#match? @modifier "public")
        name:(identifier) @name
      )
    )
  )
)
