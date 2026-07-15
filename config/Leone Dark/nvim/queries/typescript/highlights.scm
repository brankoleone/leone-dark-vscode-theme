; extends
; Leone Dark — TypeScript refinements
; Splits a few captures the default queries lump together, so the Treesitter
; output matches the VS Code theme's TextMate scopes exactly.

; Object-literal keys → nonPhotoBlue (default lumps them with property access
; as @variable.member, which the theme colors chalky).
(pair
  key: (property_identifier) @leone.objectKey)

; Type *declaration* names stay teal (@type.definition → pelorous).
; The colorscheme repaints the base @type (references / annotations) to portage,
; matching the theme's `meta.type.annotation entity.name.type` rule.
(interface_declaration
  name: (type_identifier) @type.definition)

(type_alias_declaration
  name: (type_identifier) @type.definition)

(enum_declaration
  name: (identifier) @type.definition)

; Class names → turquoise (@constructor), matching `meta.class entity.name.*`.
(class_declaration
  name: (type_identifier) @constructor)

(abstract_class_declaration
  name: (type_identifier) @constructor)

(class
  name: (type_identifier) @constructor)

; const-declared bindings → chalky. The TS grammar scopes const identifiers as
; variable.other.constant (which the theme colors chalky); let/var stay
; nonPhotoBlue via the default @variable.
(lexical_declaration
  "const"
  (variable_declarator
    name: (identifier) @leone.constant))

(lexical_declaration
  "const"
  (variable_declarator
    name: (object_pattern
      (shorthand_property_identifier_pattern) @leone.constant)))

(lexical_declaration
  "const"
  (variable_declarator
    name: (object_pattern
      (pair_pattern
        value: (identifier) @leone.constant))))

(lexical_declaration
  "const"
  (variable_declarator
    name: (array_pattern
      (identifier) @leone.constant)))

; ...but a const bound to a function/arrow keeps the function color (malibu).
; Intentionally last so it wins over @leone.constant above for the same node.
(lexical_declaration
  "const"
  (variable_declarator
    name: (identifier) @function
    value: [
      (arrow_function)
      (function_expression)
    ]))
