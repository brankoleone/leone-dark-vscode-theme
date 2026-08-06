-- leone-light.lua — GENERATED FILE, DO NOT EDIT.
-- Source template: config/Leone Light/nvim/template.lua
-- Regenerate with: pnpm generate "Leone Light"
-- Double-brace placeholders are resolved from config/Leone Light/palette.json.

local M = {}

-- Palette ({{...}} = from palette.json; literals below = UI shades from template.json)
local p = {
  newColor        = "{{newColor}}",
  newColor2       = "{{newColor2}}",
  indigo          = "{{indigo}}",
  portage         = "{{portage}}",
  softPurple      = "{{softPurple}}",
  watermelon      = "{{watermelon}}",
  froly           = "{{froly}}",
  brown           = "{{brown}}",
  whiskey         = "{{whiskey}}",
  chalky          = "{{chalky}}",
  pearl           = "{{pearl}}",
  teaGreen        = "{{teaGreen}}",
  pistachio       = "{{pistachio}}",
  deYork          = "{{deYork}}",
  mint            = "{{mint}}",
  fountainBlue    = "{{fountainBlue}}",
  pelorous        = "{{pelorous}}",
  turquoise       = "{{turquoise}}",
  nonPhotoBlue    = "{{nonPhotoBlue}}",
  pictonBlue      = "{{pictonBlue}}",
  malibu          = "{{malibu}}",
  chambray        = "{{chambray}}",
  iron            = "{{iron}}",
  silverChalice   = "{{silverChalice}}",
  nevada          = "{{nevada}}",
  santasGray      = "{{santasGray}}",
  fiord           = "{{fiord}}",
  midnightExpress = "{{midnightExpress}}",
  blackRock       = "{{blackRock}}",
  blackPearl      = "{{blackPearl}}",
  mirage          = "{{mirage}}",
  bianca          = "{{bianca}}",
  -- extra UI shades pulled from template.json literals
  cursor          = "#1D6FE0",
  errorRed        = "#D3312F",
}

function M.setup()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.o.background = "light"
  vim.g.colors_name = "leone-light"

  local function hi(group, spec)
    vim.api.nvim_set_hl(0, group, spec)
  end

  -- ── Editor / UI ───────────────────────────────────────────────
  hi("Normal",        { fg = p.silverChalice, bg = p.blackPearl })
  hi("NormalFloat",   { fg = p.silverChalice, bg = p.blackPearl })
  hi("FloatBorder",   { fg = p.mirage,        bg = p.blackPearl })
  hi("NormalNC",      { fg = p.silverChalice, bg = p.blackPearl })
  hi("ColorColumn",   { bg = p.blackRock })
  hi("Cursor",        { fg = p.blackPearl,    bg = p.cursor })
  hi("CursorLine",    { bg = p.blackRock })
  hi("CursorLineNr",  { fg = p.chambray,      bold = true })
  hi("LineNr",        { fg = p.nevada })
  hi("SignColumn",    { bg = p.blackPearl })
  hi("VertSplit",     { fg = p.mirage })
  hi("WinSeparator",  { fg = p.mirage })
  hi("Folded",        { fg = p.nevada,        bg = p.blackRock })
  hi("FoldColumn",    { fg = p.nevada })
  hi("Visual",        { bg = p.fiord })
  hi("Search",        { fg = p.chalky,        bg = p.blackRock })
  hi("IncSearch",     { fg = p.blackPearl,    bg = p.whiskey })
  hi("CurSearch",     { fg = p.blackPearl,    bg = p.chalky })
  hi("MatchParen",    { fg = p.turquoise,     bold = true })
  hi("NonText",       { fg = p.santasGray })
  hi("Whitespace",    { fg = p.santasGray })
  hi("SpecialKey",    { fg = p.santasGray })
  hi("Pmenu",         { fg = p.silverChalice, bg = p.blackPearl })
  hi("PmenuSel",      { fg = p.silverChalice, bg = p.fiord })
  hi("PmenuSbar",     { bg = p.blackRock })
  hi("PmenuThumb",    { bg = p.mirage })
  hi("StatusLine",    { fg = p.iron,          bg = p.mirage })
  hi("StatusLineNC",  { fg = p.nevada,        bg = p.bianca })
  hi("TabLine",       { fg = p.nevada,        bg = p.midnightExpress })
  hi("TabLineSel",    { fg = p.silverChalice, bg = p.blackPearl })
  hi("TabLineFill",   { bg = p.blackPearl })
  hi("Title",         { fg = p.malibu,        bold = true })
  hi("Directory",     { fg = p.malibu })
  hi("WildMenu",      { fg = "#FFFFFF",       bg = p.chambray })
  hi("QuickFixLine",  { bg = p.blackRock })
  hi("ErrorMsg",      { fg = p.errorRed })
  hi("WarningMsg",    { fg = p.whiskey })
  hi("MoreMsg",       { fg = p.mint })
  hi("ModeMsg",       { fg = p.silverChalice })
  hi("Question",      { fg = p.mint })

  -- ── Syntax (legacy groups) ────────────────────────────────────
  hi("Comment",       { fg = p.santasGray,    italic = true })
  hi("Constant",      { fg = p.whiskey })
  hi("String",        { fg = p.whiskey,       italic = true })
  hi("Character",     { fg = p.whiskey })
  hi("Number",        { fg = p.turquoise })
  hi("Boolean",       { fg = p.indigo })
  hi("Float",         { fg = p.turquoise })
  hi("Identifier",    { fg = p.nonPhotoBlue })
  hi("Function",      { fg = p.malibu })
  hi("Statement",     { fg = p.softPurple,    italic = true })
  hi("Conditional",   { fg = p.softPurple,    italic = true })
  hi("Repeat",        { fg = p.softPurple,    italic = true })
  hi("Label",         { fg = p.softPurple })
  hi("Operator",      { fg = p.pelorous })
  hi("Keyword",       { fg = p.softPurple,    italic = true })
  hi("Exception",     { fg = p.softPurple,    italic = true })
  hi("PreProc",       { fg = p.portage })
  hi("Include",       { fg = p.softPurple,    italic = true })
  hi("Define",        { fg = p.softPurple })
  hi("Macro",         { fg = p.portage })
  hi("Type",          { fg = p.pelorous })
  hi("StorageClass",  { fg = p.indigo,        italic = true })
  hi("Structure",     { fg = p.chalky })
  hi("Typedef",       { fg = p.pelorous })
  hi("Special",       { fg = p.malibu })
  hi("SpecialChar",   { fg = p.indigo })
  hi("Tag",           { fg = p.mint })
  hi("Delimiter",     { fg = p.silverChalice })
  hi("SpecialComment",{ fg = p.santasGray })
  hi("Underlined",    { fg = p.malibu,        underline = true })
  hi("Error",         { fg = p.errorRed })
  hi("Todo",          { fg = p.blackPearl,    bg = p.chalky, bold = true })

  -- ── Diagnostics ───────────────────────────────────────────────
  hi("DiagnosticError", { fg = p.errorRed })
  hi("DiagnosticWarn",  { fg = p.whiskey })
  hi("DiagnosticInfo",  { fg = p.malibu })
  hi("DiagnosticHint",  { fg = p.fountainBlue })
  hi("DiagnosticUnderlineError", { undercurl = true, sp = p.errorRed })
  hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = p.whiskey })
  hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = p.malibu })
  hi("DiagnosticUnderlineHint",  { undercurl = true, sp = p.fountainBlue })

  -- ── Git / diff ────────────────────────────────────────────────
  hi("DiffAdd",    { bg = "#DCEEDA" })
  hi("DiffChange", { bg = "#DCE7F5" })
  hi("DiffDelete", { fg = p.froly })
  hi("DiffText",   { bg = "#C3DBF2" })
  hi("diffAdded",   { fg = p.mint })
  hi("diffRemoved", { fg = p.froly })
  hi("diffChanged", { fg = p.malibu })
  hi("GitSignsAdd",    { fg = p.mint })
  hi("GitSignsChange", { fg = p.nonPhotoBlue })
  hi("GitSignsDelete", { fg = p.froly })

  -- ── Treesitter ────────────────────────────────────────────────
  hi("@comment",              { link = "Comment" })
  hi("@comment.documentation",{ fg = p.santasGray, italic = true })
  hi("@punctuation.delimiter",{ fg = p.silverChalice })
  hi("@punctuation.bracket",  { fg = p.silverChalice })
  hi("@punctuation.special",  { fg = p.softPurple })

  hi("@constant",           { fg = p.whiskey })
  hi("@constant.builtin",   { fg = p.indigo })
  hi("@constant.macro",     { fg = p.portage })
  hi("@string",             { fg = p.whiskey, italic = true })
  hi("@string.regexp",      { fg = p.fountainBlue })
  hi("@string.escape",      { fg = p.indigo })
  hi("@string.special",     { fg = p.indigo })
  hi("@character",          { fg = p.whiskey })
  hi("@number",             { fg = p.turquoise })
  hi("@number.float",       { fg = p.turquoise })
  hi("@boolean",            { fg = p.indigo })

  hi("@variable",           { fg = p.nonPhotoBlue })
  hi("@variable.builtin",   { fg = p.froly })
  hi("@variable.parameter", { fg = p.teaGreen, italic = true })
  hi("@variable.member",    { fg = p.chalky })

  hi("@function",           { fg = p.malibu })
  hi("@function.builtin",   { fg = p.malibu })
  hi("@function.call",      { fg = p.malibu })
  hi("@function.macro",     { fg = p.portage })
  hi("@constructor",        { fg = p.turquoise })
  hi("@method",             { fg = p.malibu })
  hi("@method.call",        { fg = p.malibu })

  hi("@keyword",            { fg = p.softPurple, italic = true })
  hi("@keyword.function",   { fg = p.indigo,     italic = true })
  hi("@keyword.operator",   { fg = p.pelorous })
  hi("@keyword.return",     { fg = p.softPurple, italic = true })
  hi("@keyword.import",     { fg = p.softPurple, italic = true })
  hi("@keyword.conditional",{ fg = p.softPurple, italic = true })
  hi("@keyword.repeat",     { fg = p.softPurple, italic = true })
  hi("@keyword.exception",  { fg = p.softPurple, italic = true })
  hi("@operator",           { fg = p.pelorous })

  hi("@type",               { fg = p.pelorous })
  hi("@type.builtin",       { fg = p.pistachio })
  hi("@type.definition",    { fg = p.pelorous })
  hi("@type.qualifier",     { fg = p.indigo, italic = true })
  hi("@storageclass",       { fg = p.indigo, italic = true })
  hi("@attribute",          { fg = p.pictonBlue })
  hi("@property",           { fg = p.nonPhotoBlue })
  hi("@namespace",          { fg = p.deYork })
  hi("@module",             { fg = p.deYork })
  hi("@label",              { fg = p.softPurple })

  -- markup / tags (HTML, JSX, markdown)
  hi("@tag",                { fg = p.mint })
  hi("@tag.builtin",        { fg = p.mint })
  hi("@tag.attribute",      { fg = p.deYork, italic = true })
  hi("@tag.delimiter",      { fg = p.silverChalice })
  hi("@markup.heading",     { fg = p.malibu, bold = true })
  hi("@markup.strong",      { bold = true })
  hi("@markup.italic",      { italic = true })
  hi("@markup.link",        { fg = p.malibu, underline = true })
  hi("@markup.link.url",    { fg = p.fountainBlue })
  hi("@markup.raw",         { fg = p.whiskey })
  hi("@markup.list",        { fg = p.softPurple })

  -- ── LSP semantic tokens (from semanticTokenColors) ────────────
  hi("@lsp.type.enumMember",        { fg = p.nonPhotoBlue })
  hi("@lsp.type.variable",          { fg = p.nonPhotoBlue })
  hi("@lsp.typemod.variable.constant",   { fg = p.whiskey })
  -- const variables → chalky at EVERY occurrence (definition + usage). The TS
  -- language server tags const as variable/readonly; this is what colors const
  -- *usages* yellow (Treesitter only sees the definition). Requires an attached
  -- LSP with semantic tokens (e.g. vtsls / typescript-language-server).
  hi("@lsp.typemod.variable.readonly",       { fg = p.chalky })
  hi("@lsp.typemod.variable.defaultLibrary", { fg = p.froly })
  hi("@lsp.type.namespace",         { fg = p.deYork })
  hi("@lsp.type.function",          { fg = p.malibu })
  hi("@lsp.type.method",            { fg = p.malibu })
  hi("@lsp.type.parameter",         { fg = p.teaGreen, italic = true })
  hi("@lsp.type.property",          { fg = p.chalky })
  hi("@lsp.type.class",             { fg = p.turquoise })
  hi("@lsp.type.struct",            { fg = p.chalky })
  hi("@lsp.type.interface",         { fg = p.pelorous })
  hi("@lsp.type.enum",              { fg = p.pelorous })
  hi("@lsp.type.type",              { fg = p.pelorous })
  hi("@lsp.type.keyword",           { fg = p.softPurple, italic = true })

  -- ── TypeScript / TSX (exact port of template + syntax scopes) ─
  -- Requires the after/queries/{typescript,tsx}/highlights.scm shipped
  -- alongside this file (add nvim/ to runtimepath) for the object-key,
  -- type-declaration, and class-name splits below to take effect.

  -- Types: base @type = references/annotations → portage (matches
  -- `meta.type.annotation entity.name.type`); declaration names → pelorous;
  -- class names → turquoise; primitives (string/number/…) → pistachio.
  hi("@type.typescript",            { fg = p.portage })
  hi("@type.tsx",                   { fg = p.portage })
  hi("@type.definition",            { fg = p.pelorous })
  hi("@type.builtin",               { fg = p.pistachio })
  hi("@constructor",                { fg = p.turquoise })

  -- const-declared bindings → chalky (TS grammar's variable.other.constant).
  hi("@leone.constant",             { fg = p.chalky })

  -- Object-literal key (custom capture) vs. property access.
  -- JS/TS property access is @variable.member (chalky). Object/JSON/CSS keys
  -- are @property / @leone.objectKey and stay nonPhotoBlue (matches the theme's
  -- support.type.property-name / meta.object-literal.key). Do NOT set @property
  -- to chalky here — that also repaints JSON keys, which must be nonPhotoBlue.
  hi("@leone.objectKey",            { fg = p.nonPhotoBlue })
  hi("@variable.member",            { fg = p.chalky })
  hi("@property",                   { fg = p.nonPhotoBlue })

  -- Keywords: storage words (const/let/var/class/function/modifiers) →
  -- indigo italic; word operators (new/typeof/in/instanceof/as/keyof) →
  -- softPurple. Control-flow keywords inherit the generic softPurple italic.
  hi("@keyword.typescript",          { fg = p.indigo, italic = true })
  hi("@keyword.tsx",                 { fg = p.indigo, italic = true })
  hi("@keyword.type.typescript",     { fg = p.indigo, italic = true })
  hi("@keyword.type.tsx",            { fg = p.indigo, italic = true })
  hi("@keyword.function.typescript", { fg = p.indigo, italic = true })
  hi("@keyword.function.tsx",        { fg = p.indigo, italic = true })
  hi("@keyword.modifier.typescript", { fg = p.indigo, italic = true })
  hi("@keyword.modifier.tsx",        { fg = p.indigo, italic = true })
  hi("@keyword.operator.typescript", { fg = p.softPurple })
  hi("@keyword.operator.tsx",        { fg = p.softPurple })
  hi("@keyword.conditional.ternary", { fg = p.pelorous })

  -- Functions / methods / calls → malibu; decorators → pictonBlue.
  hi("@function.method",            { fg = p.malibu })
  hi("@function.method.call",       { fg = p.malibu })
  hi("@function.call",              { fg = p.malibu })
  hi("@attribute",                  { fg = p.pictonBlue })

  -- JSX: component tags → red (newColor2), intrinsic tags → mint,
  -- attributes → deYork italic, delimiters → silverChalice.
  hi("@tag.tsx",                    { fg = p.newColor2 })
  hi("@tag.builtin",                { fg = p.mint })
  hi("@tag.attribute",              { fg = p.deYork, italic = true })
  hi("@tag.delimiter",              { fg = p.silverChalice })

  -- Misc: SCREAMING_CASE consts → chalky, escapes/entities → indigo,
  -- link-ish string urls → malibu.
  hi("@constant",                   { fg = p.chalky })
  hi("@character.special",          { fg = p.indigo })
  hi("@string.special.url",         { fg = p.malibu })

  -- ── Terminal colors (from template terminal.ansi*) ────────────
  vim.g.terminal_color_0  = p.silverChalice
  vim.g.terminal_color_1  = p.froly
  vim.g.terminal_color_2  = p.mint
  vim.g.terminal_color_3  = p.chalky
  vim.g.terminal_color_4  = p.malibu
  vim.g.terminal_color_5  = p.softPurple
  vim.g.terminal_color_6  = p.fountainBlue
  vim.g.terminal_color_7  = p.nevada
  vim.g.terminal_color_8  = p.iron
  vim.g.terminal_color_9  = p.watermelon
  vim.g.terminal_color_10 = p.pistachio
  vim.g.terminal_color_11 = p.whiskey
  vim.g.terminal_color_12 = p.pictonBlue
  vim.g.terminal_color_13 = p.newColor
  vim.g.terminal_color_14 = p.turquoise
  vim.g.terminal_color_15 = p.fiord
end

M.setup()
return M
