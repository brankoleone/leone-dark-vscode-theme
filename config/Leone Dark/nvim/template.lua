-- leone-dark.lua — GENERATED FILE, DO NOT EDIT.
-- Source template: config/Leone Dark/nvim/template.lua
-- Regenerate with: pnpm generate "Leone Dark"
-- Double-brace placeholders are resolved from config/Leone Dark/palette.json.

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
  fiord           = "{{fiord}}",
  midnightExpress = "{{midnightExpress}}",
  blackRock       = "{{blackRock}}",
  blackPearl      = "{{blackPearl}}",
  mirage          = "{{mirage}}",
  vulcan          = "{{vulcan}}",
  ebonyClay       = "{{ebonyClay}}",
  -- extra UI shades pulled from template.json literals
  bgFloat         = "#212530",
  bgSelection     = "#455368",
  bgVisualNos     = "#2C313C",
  bgPopupSelect   = "#383E4A",
  bgTab           = "#2E343F",
  bgSidebar       = "#1C202B",
  border          = "#252A35",
  cursor          = "#528BFF",
  errorRed        = "#C24038",
  white           = "#FFFFFF",
  statusText      = "#E7E7E7",
}

function M.setup()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "leone-dark"

  local function hi(group, spec)
    vim.api.nvim_set_hl(0, group, spec)
  end

  local function link(group, target)
    hi(group, { link = target })
  end

  -- ── Editor / UI ───────────────────────────────────────────────
  hi("Normal",        { fg = p.silverChalice, bg = p.blackPearl })
  hi("NormalNC",       { fg = p.silverChalice, bg = p.blackPearl })
  hi("NormalFloat",    { fg = p.silverChalice, bg = p.bgFloat })
  hi("FloatBorder",    { fg = p.fiord,         bg = p.bgFloat })
  hi("FloatTitle",     { fg = p.pictonBlue,    bg = p.bgFloat, bold = true })
  hi("WinSeparator",   { fg = p.border,        bg = p.blackPearl })
  hi("VertSplit",      { fg = p.border,        bg = p.blackPearl })
  hi("ColorColumn",    { bg = p.midnightExpress })
  hi("Cursor",         { fg = p.blackPearl,    bg = p.cursor })
  hi("lCursor",        { fg = p.blackPearl,    bg = p.cursor })
  hi("CursorIM",       { fg = p.blackPearl,    bg = p.cursor })
  hi("CursorColumn",   { bg = p.blackRock })
  hi("CursorLine",     { bg = p.blackRock })
  hi("CursorLineNr",   { fg = p.chambray,      bg = p.blackRock, bold = true })
  hi("LineNr",         { fg = p.fiord,         bg = p.blackPearl })
  hi("LineNrAbove",    { fg = p.fiord,         bg = p.blackPearl })
  hi("LineNrBelow",    { fg = p.fiord,         bg = p.blackPearl })
  hi("SignColumn",     { fg = p.fiord,         bg = p.blackPearl })
  hi("FoldColumn",     { fg = p.fiord,         bg = p.blackPearl })
  hi("Folded",         { fg = p.nevada,        bg = p.midnightExpress })
  hi("EndOfBuffer",    { fg = p.mirage,        bg = p.blackPearl })
  hi("NonText",        { fg = p.fiord })
  hi("Whitespace",     { fg = p.fiord })
  hi("SpecialKey",     { fg = p.fiord })
  hi("Conceal",        { fg = p.fiord })

  hi("Visual",         { bg = p.bgSelection })
  hi("VisualNOS",       { bg = p.bgVisualNos })
  hi("Search",         { fg = p.chalky,        bg = "#000000" })
  hi("IncSearch",       { fg = p.blackPearl,    bg = p.whiskey })
  hi("CurSearch",       { fg = p.blackPearl,    bg = p.chalky })
  hi("Substitute",      { fg = p.blackPearl,    bg = p.watermelon })
  hi("MatchParen",      { fg = p.chalky,        bg = "#000000", bold = true })

  hi("Pmenu",           { fg = p.silverChalice, bg = p.blackPearl })
  hi("PmenuSel",         { fg = p.white,         bg = p.bgPopupSelect })
  hi("PmenuKind",        { fg = p.pictonBlue,    bg = p.blackPearl })
  hi("PmenuKindSel",     { fg = p.pictonBlue,    bg = p.bgPopupSelect })
  hi("PmenuExtra",       { fg = p.nevada,        bg = p.blackPearl })
  hi("PmenuExtraSel",    { fg = p.nevada,        bg = p.bgPopupSelect })
  hi("PmenuSbar",        { bg = "#4E5666" })
  hi("PmenuThumb",       { bg = "#747D91" })
  hi("WildMenu",         { fg = p.white,         bg = p.bgPopupSelect })

  hi("StatusLine",       { fg = p.statusText,    bg = p.chambray })
  hi("StatusLineNC",     { fg = p.silverChalice, bg = p.blackPearl })
  hi("TabLine",          { fg = p.silverChalice, bg = p.bgTab })
  hi("TabLineSel",       { fg = "#DCDCDC",       bg = p.border, bold = true })
  hi("TabLineFill",      { bg = p.blackPearl })
  hi("WinBar",           { fg = p.silverChalice, bg = p.blackPearl })
  hi("WinBarNC",         { fg = p.nevada,        bg = p.blackPearl })

  hi("MsgArea",          { fg = p.silverChalice, bg = p.blackPearl })
  hi("ModeMsg",          { fg = p.deYork })
  hi("MoreMsg",          { fg = p.deYork })
  hi("Question",         { fg = p.deYork })
  hi("WarningMsg",       { fg = p.whiskey })
  hi("ErrorMsg",         { fg = p.errorRed })
  hi("Directory",        { fg = p.deYork })
  hi("Title",            { fg = p.malibu,        bold = true })

  -- ── Diff ──────────────────────────────────────────────────────
  hi("DiffAdd",     { fg = p.mint,       bg = "#1F3638" })
  hi("DiffChange",  { fg = p.malibu,     bg = "#1F2D3D" })
  hi("DiffDelete",  { fg = p.watermelon, bg = "#3A202A" })
  hi("DiffText",    { fg = p.pictonBlue, bg = p.chambray, bold = true })
  hi("Added",       { fg = p.mint })
  hi("Changed",     { fg = p.malibu })
  hi("Removed",     { fg = p.watermelon })

  -- ── Diagnostics ───────────────────────────────────────────────
  hi("DiagnosticError", { fg = p.errorRed })
  hi("DiagnosticWarn",  { fg = p.whiskey })
  hi("DiagnosticInfo",  { fg = p.malibu })
  hi("DiagnosticHint",  { fg = p.fountainBlue })
  hi("DiagnosticOk",    { fg = p.mint })
  hi("DiagnosticUnderlineError", { sp = p.errorRed,     undercurl = true })
  hi("DiagnosticUnderlineWarn",  { sp = p.whiskey,      undercurl = true })
  hi("DiagnosticUnderlineInfo",  { sp = p.malibu,       undercurl = true })
  hi("DiagnosticUnderlineHint",  { sp = p.fountainBlue, undercurl = true })
  hi("DiagnosticUnderlineOk",    { sp = p.mint,         undercurl = true })
  hi("DiagnosticVirtualTextError", { fg = p.errorRed,     bg = "#2C202A" })
  hi("DiagnosticVirtualTextWarn",  { fg = p.whiskey,      bg = "#2D2A24" })
  hi("DiagnosticVirtualTextInfo",  { fg = p.malibu,       bg = "#202A35" })
  hi("DiagnosticVirtualTextHint",  { fg = p.fountainBlue, bg = "#1F2D33" })

  -- ── Syntax (legacy groups) ────────────────────────────────────
  hi("Comment",       { fg = p.nevada })
  hi("Constant",      { fg = p.chalky })
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
  hi("Label",         { fg = p.portage })
  hi("Operator",      { fg = p.pelorous })
  hi("Keyword",       { fg = p.softPurple,    italic = true })
  hi("Exception",     { fg = p.softPurple,    italic = true })
  hi("PreProc",       { fg = p.softPurple,    italic = true })
  hi("Include",       { fg = p.softPurple,    italic = true })
  hi("Define",        { fg = p.portage })
  hi("Macro",         { fg = p.portage })
  hi("PreCondit",     { fg = p.portage })
  hi("Type",          { fg = p.pistachio })
  hi("StorageClass",  { fg = p.indigo,        italic = true })
  hi("Structure",     { fg = p.pelorous })
  hi("Typedef",       { fg = p.pelorous })
  hi("Special",       { fg = p.indigo })
  hi("SpecialChar",   { fg = p.indigo })
  hi("Tag",           { fg = p.mint })
  hi("Delimiter",     { fg = p.silverChalice })
  hi("SpecialComment",{ fg = p.pictonBlue })
  hi("Debug",         { fg = p.watermelon })
  hi("Underlined",    { fg = p.malibu,        underline = true })
  hi("Ignore",        { fg = p.fiord })
  hi("Error",         { fg = p.errorRed })
  hi("Todo",          { fg = p.chalky,        bold = true })

  -- ── Treesitter ────────────────────────────────────────────────
  hi("@comment",              { fg = p.nevada })
  hi("@none",                 { fg = p.silverChalice })
  hi("@preproc",              { fg = p.softPurple, italic = true })
  hi("@define",               { fg = p.portage })
  hi("@operator",             { fg = p.pelorous })

  hi("@punctuation.delimiter",{ fg = p.silverChalice })
  hi("@punctuation.bracket",  { fg = p.iron })
  hi("@punctuation.special",  { fg = p.softPurple })

  hi("@string",              { fg = p.whiskey, italic = true })
  hi("@string.documentation",{ fg = p.whiskey, italic = true })
  hi("@string.regexp",       { fg = p.fountainBlue })
  hi("@string.escape",       { fg = p.indigo })
  hi("@string.special",      { fg = p.indigo })
  hi("@character",           { fg = p.whiskey })
  hi("@character.special",   { fg = p.indigo })
  hi("@boolean",             { fg = p.indigo })
  hi("@number",              { fg = p.turquoise })
  hi("@number.float",        { fg = p.turquoise })

  hi("@function",            { fg = p.malibu })
  hi("@function.builtin",    { fg = p.malibu })
  hi("@function.call",       { fg = p.malibu })
  hi("@function.macro",      { fg = p.malibu })
  hi("@function.method",     { fg = p.malibu })
  hi("@function.method.call",{ fg = p.malibu })
  hi("@method",              { fg = p.malibu })
  hi("@method.call",         { fg = p.malibu })
  hi("@constructor",         { fg = p.malibu })
  hi("@parameter",           { fg = p.teaGreen, italic = true })

  hi("@keyword",              { fg = p.softPurple, italic = true })
  hi("@keyword.conditional",  { fg = p.softPurple, italic = true })
  hi("@keyword.repeat",       { fg = p.softPurple, italic = true })
  hi("@keyword.return",       { fg = p.softPurple, italic = true })
  hi("@keyword.exception",    { fg = p.softPurple, italic = true })
  hi("@keyword.declaration",  { fg = p.indigo,     italic = true })
  hi("@keyword.function",     { fg = p.indigo,     italic = true })
  hi("@keyword.import",       { fg = p.softPurple, italic = true })
  hi("@keyword.coroutine",    { fg = p.softPurple, italic = true })
  hi("@keyword.modifier",     { fg = p.softPurple, italic = true })
  hi("@keyword.operator",     { fg = p.softPurple, italic = true })
  hi("@keyword.storage",      { fg = p.indigo,     italic = true })
  hi("@keyword.type",         { fg = p.indigo,     italic = true })
  hi("@conditional",          { fg = p.softPurple, italic = true })
  hi("@repeat",               { fg = p.softPurple, italic = true })
  hi("@exception",            { fg = p.softPurple, italic = true })

  hi("@variable",           { fg = p.nonPhotoBlue })
  hi("@variable.builtin",   { fg = p.nonPhotoBlue })
  hi("@variable.parameter", { fg = p.teaGreen, italic = true })
  hi("@variable.member",    { fg = p.nonPhotoBlue })
  hi("@property",           { fg = p.nonPhotoBlue })
  hi("@field",              { fg = p.nonPhotoBlue })
  hi("@constant",           { fg = p.chalky })
  hi("@constant.builtin",   { fg = p.indigo })
  hi("@constant.macro",     { fg = p.chalky })
  hi("@module",             { fg = p.deYork })
  hi("@namespace",          { fg = p.deYork })
  hi("@symbol",             { fg = p.nonPhotoBlue })

  hi("@type",               { fg = p.pelorous })
  hi("@type.builtin",       { fg = p.pistachio })
  hi("@type.definition",    { fg = p.pelorous })
  hi("@type.qualifier",     { fg = p.softPurple, italic = true })
  hi("@storageclass",       { fg = p.indigo, italic = true })
  hi("@attribute",          { fg = p.pictonBlue })
  hi("@label",              { fg = p.portage })

  -- markup / tags (HTML, JSX, markdown)
  hi("@tag",                 { fg = p.newColor2 })
  hi("@tag.builtin",         { fg = p.mint })
  hi("@tag.html",            { fg = p.mint })
  hi("@tag.html_tags",       { fg = p.mint })
  hi("@tag.tsx",             { fg = p.newColor2 })
  hi("@tag.builtin.tsx",     { fg = p.mint })
  hi("@tag.javascript",      { fg = p.newColor2 })
  hi("@tag.builtin.javascript", { fg = p.mint })
  hi("@tag.attribute",       { fg = p.deYork, italic = true })
  hi("@tag.delimiter",       { fg = p.silverChalice })

  hi("@markup.heading",           { fg = p.malibu, bold = true })
  hi("@markup.heading.1.markdown",{ fg = p.malibu, bold = true })
  hi("@markup.raw",               { fg = p.whiskey, italic = true })
  hi("@markup.link",              { fg = p.malibu, underline = true })
  hi("@markup.link.url",          { fg = p.malibu, underline = true })
  hi("@markup.link.label",        { fg = p.deYork })
  hi("@markup.list",              { fg = p.turquoise })
  hi("@markup.strong",            { fg = p.chalky, bold = true })
  hi("@markup.italic",            { fg = p.pistachio, italic = true })
  hi("@markup.quote",             { fg = p.nevada, italic = true })

  hi("@text",           { fg = p.silverChalice })
  hi("@text.strong",    { fg = p.chalky, bold = true })
  hi("@text.emphasis",  { fg = p.pistachio, italic = true })
  hi("@text.title",     { fg = p.malibu, bold = true })
  hi("@text.literal",   { fg = p.whiskey, italic = true })
  hi("@text.uri",       { fg = p.malibu, underline = true })
  hi("@text.reference", { fg = p.deYork })
  hi("@text.todo",      { fg = p.chalky, bold = true })

  hi("@diff.plus",  { fg = p.mint })
  hi("@diff.minus", { fg = p.watermelon })
  hi("@diff.delta", { fg = p.malibu })

  -- ── Links ─────────────────────────────────────────────────────
  link("Float",       "Number")
  link("htmlTag",     "Delimiter")
  link("htmlEndTag",  "Delimiter")
  link("htmlTagName", "Tag")
  link("htmlArg",     "@tag.attribute")
  link("xmlTagName",  "Tag")
  link("xmlAttrib",   "@tag.attribute")
  link("markdownHeadingDelimiter", "Ignore")
  link("markdownCode",      "@markup.raw")
  link("markdownCodeBlock", "@markup.raw")
  link("markdownBold",      "@markup.strong")
  link("markdownItalic",    "@markup.italic")

  link("GitSignsAdd",    "Added")
  link("GitSignsChange", "Changed")
  link("GitSignsDelete", "Removed")
  link("GitGutterAdd",    "Added")
  link("GitGutterChange", "Changed")
  link("GitGutterDelete", "Removed")

  link("LspReferenceText",  "VisualNOS")
  link("LspReferenceRead",  "VisualNOS")
  link("LspReferenceWrite", "VisualNOS")

  -- ── Plugins: nvim-tree ────────────────────────────────────────
  hi("NvimTreeNormal",           { fg = p.nevada, bg = p.bgSidebar })
  hi("NvimTreeNormalNC",         { fg = p.nevada, bg = p.bgSidebar })
  hi("NvimTreeEndOfBuffer",      { fg = p.bgSidebar, bg = p.bgSidebar })
  hi("NvimTreeWinSeparator",     { fg = p.border, bg = p.bgSidebar })
  hi("NvimTreeRootFolder",       { fg = p.pictonBlue, bold = true })
  hi("NvimTreeFolderName",       { fg = p.silverChalice })
  hi("NvimTreeOpenedFolderName", { fg = p.silverChalice, bold = true })
  hi("NvimTreeEmptyFolderName",  { fg = p.fiord })
  hi("NvimTreeFileIcon",         { fg = p.silverChalice })
  hi("NvimTreeSymlink",          { fg = p.fountainBlue })
  hi("NvimTreeExecFile",         { fg = p.pistachio })
  hi("NvimTreeSpecialFile",      { fg = p.chalky, underline = true })
  hi("NvimTreeImageFile",        { fg = p.softPurple })
  hi("NvimTreeIndentMarker",     { fg = p.fiord })
  hi("NvimTreeGitDirty",         { fg = p.malibu })
  hi("NvimTreeGitNew",           { fg = p.deYork })
  hi("NvimTreeGitDeleted",       { fg = p.watermelon })
  hi("NvimTreeGitIgnored",       { fg = "#343E50" })

  -- ── Plugins: telescope ────────────────────────────────────────
  hi("TelescopeNormal",    { fg = p.silverChalice, bg = p.bgFloat })
  hi("TelescopeBorder",    { fg = p.fiord,         bg = p.bgFloat })
  hi("TelescopeSelection", { fg = p.white,         bg = p.blackRock })
  hi("TelescopeMatching",  { fg = p.pictonBlue,    bold = true })

  -- ── Plugins: which-key ────────────────────────────────────────
  hi("WhichKey",          { fg = p.pictonBlue })
  hi("WhichKeyGroup",     { fg = p.deYork })
  hi("WhichKeyDesc",      { fg = p.silverChalice })
  hi("WhichKeySeparator", { fg = p.fiord })
  hi("WhichKeyFloat",     { bg = p.bgFloat })

  -- ── LSP semantic tokens ───────────────────────────────────────
  hi("@lsp.type.namespace",   { fg = p.deYork })
  hi("@lsp.type.type",        { fg = p.pelorous })
  hi("@lsp.type.class",       { fg = p.pelorous })
  hi("@lsp.type.enum",        { fg = p.pelorous })
  hi("@lsp.type.interface",   { fg = p.pelorous })
  hi("@lsp.type.struct",      { fg = p.pelorous })
  hi("@lsp.type.typeParameter", { fg = p.pelorous })
  hi("@lsp.type.parameter",   { fg = p.teaGreen, italic = true })
  hi("@lsp.type.variable",    { fg = p.nonPhotoBlue })
  hi("@lsp.type.property",    { fg = p.nonPhotoBlue })
  hi("@lsp.type.enumMember",  { fg = p.chalky })
  hi("@lsp.type.event",       { fg = p.nonPhotoBlue })
  hi("@lsp.type.function",    { fg = p.malibu })
  hi("@lsp.type.method",      { fg = p.malibu })
  hi("@lsp.type.macro",       { fg = p.malibu })
  hi("@lsp.type.constructor", { fg = p.malibu })
  hi("@lsp.type.keyword",     { fg = p.softPurple, italic = true })
  hi("@lsp.type.modifier",    { fg = p.softPurple, italic = true })
  hi("@lsp.type.boolean",     { fg = p.indigo })
  hi("@lsp.type.comment",     { fg = p.nevada })
  hi("@lsp.type.string",      { fg = p.whiskey, italic = true })
  hi("@lsp.type.number",      { fg = p.turquoise })
  hi("@lsp.type.regexp",      { fg = p.fountainBlue })
  hi("@lsp.type.operator",    { fg = p.pelorous })

  hi("@lsp.mod.defaultLibrary", { fg = p.froly })
  hi("@lsp.mod.deprecated",     { strikethrough = true })
  hi("@lsp.mod.constant",       { fg = p.chalky })
  hi("@lsp.typemod.type.defaultLibrary",         { fg = p.portage })
  hi("@lsp.typemod.class.defaultLibrary",        { fg = p.portage })
  hi("@lsp.typemod.enum.defaultLibrary",         { fg = p.portage })
  hi("@lsp.typemod.interface.defaultLibrary",    { fg = p.portage })
  hi("@lsp.typemod.struct.defaultLibrary",       { fg = p.portage })
  hi("@lsp.typemod.typeParameter.defaultLibrary",{ fg = p.portage })
  hi("@lsp.typemod.type.imported",         { fg = p.portage })
  hi("@lsp.typemod.class.imported",        { fg = p.portage })
  hi("@lsp.typemod.enum.imported",         { fg = p.portage })
  hi("@lsp.typemod.interface.imported",    { fg = p.portage })
  hi("@lsp.typemod.struct.imported",       { fg = p.portage })
  hi("@lsp.typemod.typeParameter.imported",{ fg = p.portage })
  hi("@lsp.typemod.type.declaration",         { fg = p.pelorous })
  hi("@lsp.typemod.class.declaration",        { fg = p.pelorous })
  hi("@lsp.typemod.enum.declaration",         { fg = p.pelorous })
  hi("@lsp.typemod.interface.declaration",    { fg = p.pelorous })
  hi("@lsp.typemod.struct.declaration",       { fg = p.pelorous })
  hi("@lsp.typemod.typeParameter.declaration",{ fg = p.pelorous })
  hi("@lsp.typemod.type.definition",         { fg = p.pelorous })
  hi("@lsp.typemod.class.definition",        { fg = p.pelorous })
  hi("@lsp.typemod.enum.definition",         { fg = p.pelorous })
  hi("@lsp.typemod.interface.definition",    { fg = p.pelorous })
  hi("@lsp.typemod.struct.definition",       { fg = p.pelorous })
  hi("@lsp.typemod.typeParameter.definition",{ fg = p.pelorous })
  hi("@lsp.typemod.variable.defaultLibrary", { fg = p.nonPhotoBlue })
  hi("@lsp.typemod.variable.constant",       { fg = p.chalky })
  hi("@lsp.typemod.variable.readonly",       { fg = p.chalky })
  hi("@lsp.typemod.parameter.defaultLibrary",{ fg = p.teaGreen, italic = true })
  hi("@lsp.typemod.parameter.constant",      { fg = p.teaGreen, italic = true })
  hi("@lsp.typemod.parameter.declaration",   { fg = p.teaGreen, italic = true })
  hi("@lsp.typemod.parameter.definition",    { fg = p.teaGreen, italic = true })
  hi("@lsp.typemod.parameter.readonly",      { fg = p.teaGreen, italic = true })
  hi("@lsp.typemod.property.defaultLibrary", { fg = p.nonPhotoBlue })
  hi("@lsp.typemod.property.constant",       { fg = p.chalky })
  hi("@lsp.typemod.property.readonly",       { fg = p.chalky })
  hi("@lsp.typemod.enumMember.defaultLibrary", { fg = p.chalky })
  hi("@lsp.typemod.enumMember.readonly",       { fg = p.chalky })
  hi("@lsp.typemod.function.defaultLibrary", { fg = p.malibu })
  hi("@lsp.typemod.function.declaration",    { fg = p.malibu })
  hi("@lsp.typemod.function.definition",     { fg = p.malibu })
  hi("@lsp.typemod.function.static",         { fg = p.malibu })
  hi("@lsp.typemod.method.defaultLibrary",   { fg = p.malibu })
  hi("@lsp.typemod.method.declaration",      { fg = p.malibu })
  hi("@lsp.typemod.method.definition",       { fg = p.malibu })
  hi("@lsp.typemod.method.static",           { fg = p.malibu })

  -- ── Terminal colors ───────────────────────────────────────────
  vim.g.terminal_color_0  = "#3F4451"
  vim.g.terminal_color_1  = p.froly
  vim.g.terminal_color_2  = p.mint
  vim.g.terminal_color_3  = p.chalky
  vim.g.terminal_color_4  = p.malibu
  vim.g.terminal_color_5  = "#C162DE"
  vim.g.terminal_color_6  = p.fountainBlue
  vim.g.terminal_color_7  = "#E6E6E6"
  vim.g.terminal_color_8  = "#4F5666"
  vim.g.terminal_color_9  = p.watermelon
  vim.g.terminal_color_10 = "#A5E075"
  vim.g.terminal_color_11 = "#F0A45D"
  vim.g.terminal_color_12 = p.pictonBlue
  vim.g.terminal_color_13 = "#DE73FF"
  vim.g.terminal_color_14 = p.turquoise
  vim.g.terminal_color_15 = "#D7DAE0"
end

M.setup()
return M
