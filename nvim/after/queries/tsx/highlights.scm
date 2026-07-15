; extends
; Leone Dark — TSX refinements
; TSX does not inherit the typescript *after* queries, so the same refinements
; are repeated here. JSX component vs. intrinsic-tag coloring is already handled
; by the bundled jsx query (@tag vs. @tag.builtin) + the colorscheme.

; Object-literal keys → nonPhotoBlue (vs. property access → chalky).
(pair
  key: (property_identifier) @leone.objectKey)

; Type *declaration* names → pelorous; base @type (references) → portage.
(interface_declaration
  name: (type_identifier) @type.definition)

(type_alias_declaration
  name: (type_identifier) @type.definition)

(enum_declaration
  name: (identifier) @type.definition)

; Class names → turquoise.
(class_declaration
  name: (type_identifier) @constructor)

(abstract_class_declaration
  name: (type_identifier) @constructor)

(class
  name: (type_identifier) @constructor)

; const-declared bindings → chalky (TS grammar scopes them variable.other.constant);
; let/var stay nonPhotoBlue via the default @variable.
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
