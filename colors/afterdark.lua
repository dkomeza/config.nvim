-- After Dark colorscheme for Neovim 0.11+
-- Tree-sitter + LSP semantic tokens + lualine + nvim-tree + blink + telescope
-- Italic comments enabled by default.

local opt = vim.g.afterdark_config or {}

local cfg = {
  transparent = opt.transparent or false, -- see note below
  italic_comments = opt.italic_comments ~= false, -- default true
  italic_keywords = opt.italic_keywords or false,
  dim_inactive = opt.dim_inactive or false,
}

vim.o.termguicolors = true
vim.o.background = "dark"

-- Palette (from your VS Code theme)
local p = {
  bg = "#0a1015",
  bg_alt = "#0d1118",
  bg_dim = "#0e1420",
  border = "#1e293e",

  fg = "#c8d1df",
  fg_muted = "#6c8093",
  fg_alt = "#a8b6cc",

  blue = "#88abf9",
  cyan = "#53c6ba",
  teal = "#7ecec6",

  magenta = "#ba7bcc",
  pink = "#f386bf",

  yellow = "#e8c37d",
  orange = "#E6A26F",

  green = "#98c379",

  error = "#e16ba0",
  warn = "#e8c37d",
  info = "#88abf9",
  hint = "#6c8093",

  selection = "#2a3b5a",
  cursorline = "#0e1420",
  word_bg = "#484e5b",
  quote = "#b38098",
}

local function hl(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end
local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to })
end

vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("hi clear " .. vim.g.colors_name)
end
vim.g.colors_name = "afterdark"

local bg = cfg.transparent and "NONE" or p.bg
local float_bg = cfg.transparent and "NONE" or p.bg
local sidebar_bg = cfg.transparent and "NONE" or p.bg
local status_bg = cfg.transparent and p.bg_alt or p.bg_alt

-- Editor UI
hl("Normal", { fg = p.fg, bg = bg })
hl("NormalNC", { fg = p.fg, bg = cfg.dim_inactive and p.bg_dim or bg })
hl("NormalFloat", { fg = p.fg, bg = float_bg })
hl("FloatBorder", { fg = p.fg_muted, bg = float_bg })
hl("FloatTitle", { fg = p.blue, bg = float_bg, bold = true })

hl("Cursor", { reverse = true })
hl("CursorLine", { bg = p.cursorline })
hl("CursorColumn", { bg = p.cursorline })
hl("ColorColumn", { bg = p.bg_dim })
hl("LineNr", { fg = p.fg_muted })
hl("CursorLineNr", { fg = p.fg_alt, bold = true })
hl("SignColumn", { bg = bg })
hl("FoldColumn", { fg = p.fg_muted, bg = bg })

hl("WinSeparator", { fg = p.border, bg = bg })
hl("VertSplit", { fg = p.border, bg = bg })

hl("Pmenu", { fg = p.fg, bg = float_bg })
hl("PmenuSel", { fg = p.fg, bg = p.selection, bold = true })
hl("PmenuSbar", { bg = p.bg_dim })
hl("PmenuThumb", { bg = p.border })

hl("Search", { fg = p.fg, bg = p.selection })
hl("IncSearch", { fg = p.bg, bg = p.pink, bold = true })
hl("CurSearch", { fg = p.bg, bg = p.pink, bold = true })

hl("Visual", { bg = p.selection })
hl("VisualNOS", { bg = p.selection })

hl("MatchParen", { fg = p.fg, bg = p.bg_dim, bold = true })
hl("Whitespace", { fg = p.fg_muted })
hl("NonText", { fg = p.fg_muted })
hl("SpecialKey", { fg = p.fg_muted })

hl("StatusLine", { fg = p.fg_muted, bg = status_bg })
hl("StatusLineNC", { fg = p.fg_muted, bg = bg })
hl("TabLine", { fg = p.fg_muted, bg = p.bg_dim })
hl("TabLineSel", { fg = p.fg, bg = bg, bold = true })
hl("TabLineFill", { bg = p.bg_dim })

hl("Directory", { fg = p.cyan })
hl("Title", { fg = p.green, bold = true })
hl("ErrorMsg", { fg = p.error, bold = true })
hl("WarningMsg", { fg = p.warn, bold = true })
hl("MoreMsg", { fg = p.green, bold = true })
hl("Question", { fg = p.green, bold = true })

-- Diff
hl("DiffAdd", { fg = p.green })
hl("DiffChange", { fg = p.blue })
hl("DiffDelete", { fg = p.magenta })
hl("DiffText", { fg = p.blue, bg = p.bg_dim, bold = true })

-- Standard syntax
hl("Comment", {
  fg = p.quote,
  italic = cfg.italic_comments,
})
hl("Constant", { fg = p.yellow })
hl("String", { fg = p.green })
hl("Character", { fg = p.green })
hl("Number", { fg = p.yellow })
hl("Boolean", { fg = p.yellow })
hl("Float", { fg = p.yellow })

hl("Identifier", { fg = p.blue })
hl("Function", { fg = p.cyan })

hl("Statement", { fg = p.magenta, italic = cfg.italic_keywords })
hl("Conditional", { fg = p.magenta, italic = cfg.italic_keywords })
hl("Repeat", { fg = p.magenta, italic = cfg.italic_keywords })
hl("Label", { fg = p.orange })
hl("Operator", { fg = p.magenta })
hl("Keyword", { fg = p.magenta, italic = cfg.italic_keywords })
hl("Exception", { fg = p.pink })

hl("PreProc", { fg = p.magenta })
hl("Include", { fg = p.magenta })
hl("Define", { fg = p.magenta })
hl("Macro", { fg = p.magenta })
hl("PreCondit", { fg = p.magenta })

hl("Type", { fg = p.yellow })
hl("StorageClass", { fg = p.yellow })
hl("Structure", { fg = p.yellow })
hl("Typedef", { fg = p.yellow })

hl("Special", { fg = p.cyan })
hl("SpecialChar", { fg = p.cyan })
hl("Tag", { fg = p.cyan })
hl("Delimiter", { fg = p.fg_muted })
hl("SpecialComment", { fg = p.quote, italic = cfg.italic_comments })
hl("Debug", { fg = p.magenta })

hl("Todo", { fg = p.bg, bg = p.yellow, bold = true })
hl("Underlined", { underline = true })
hl("Bold", { bold = true })
hl("Italic", { italic = true })

-- Diagnostics
hl("DiagnosticError", { fg = p.error })
hl("DiagnosticWarn", { fg = p.warn })
hl("DiagnosticInfo", { fg = p.info })
hl("DiagnosticHint", { fg = p.hint })
hl("DiagnosticOk", { fg = p.green })

hl("DiagnosticUnderlineError", { sp = p.error, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = p.warn, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = p.info, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = p.hint, undercurl = true })

hl("DiagnosticVirtualTextError", { fg = p.error })
hl("DiagnosticVirtualTextWarn", { fg = p.warn })
hl("DiagnosticVirtualTextInfo", { fg = p.info })
hl("DiagnosticVirtualTextHint", { fg = p.hint })

-- "Unnecessary" (faded) code
hl("DiagnosticUnnecessary", { fg = p.fg_muted })

-- LSP UX
hl("LspInlayHint", { fg = p.fg_muted, bg = p.bg_dim, italic = true })
hl("LspCodeLens", { fg = p.fg_muted, italic = true })
hl("LspSignatureActiveParameter", { fg = p.yellow, bold = true })

-- LSP references (word highlight)
hl("LspReferenceText", { bg = p.word_bg })
hl("LspReferenceRead", { bg = p.word_bg })
hl("LspReferenceWrite", { bg = p.word_bg })

-- Tree-sitter
hl("@comment", { link = "Comment" })
hl("@punctuation", { fg = p.fg_muted })
hl("@punctuation.bracket", { fg = p.fg_muted })
hl("@punctuation.delimiter", { fg = p.fg_muted })
hl("@operator", { fg = p.magenta })

hl("@string", { link = "String" })
hl("@string.escape", { fg = p.cyan })
hl("@character", { link = "Character" })
hl("@boolean", { link = "Boolean" })
hl("@number", { link = "Number" })
hl("@float", { link = "Float" })

hl("@constant", { fg = p.yellow })
hl("@constant.builtin", { fg = p.yellow, bold = true })
hl("@constant.macro", { fg = p.yellow })

hl("@variable", { fg = p.blue })
hl("@variable.builtin", { fg = p.pink })
hl("@variable.member", { fg = p.orange })
hl("@field", { fg = p.orange })
hl("@property", { fg = p.orange })
hl("@parameter", { fg = p.yellow })

hl("@type", { fg = p.yellow })
hl("@type.builtin", { fg = p.pink })
hl("@type.definition", { fg = p.yellow })
hl("@attribute", { fg = "#E6AC6F" })
hl("@namespace", { fg = p.fg })

hl("@function", { fg = p.cyan })
hl("@function.builtin", { fg = p.cyan, bold = true })
hl("@method", { fg = p.cyan })
hl("@constructor", { fg = p.cyan })

hl("@keyword", { fg = p.magenta, italic = cfg.italic_keywords })
hl("@keyword.operator", { fg = p.magenta })
hl("@keyword.return", { fg = p.magenta })
hl("@conditional", { fg = p.magenta })
hl("@repeat", { fg = p.magenta })
hl("@exception", { fg = p.pink })

hl("@tag", { fg = p.cyan })
hl("@tag.delimiter", { fg = p.fg_muted })
hl("@tag.attribute", { fg = p.orange })

-- LSP semantic tokens (0.10+)
hl("@lsp.type.function", { fg = p.cyan })
hl("@lsp.type.method", { fg = p.cyan })
hl("@lsp.type.constructor", { fg = p.cyan })

hl("@lsp.type.variable", { fg = p.yellow })
hl("@lsp.type.parameter", { fg = p.yellow })
hl("@lsp.type.property", { fg = p.orange })
hl("@lsp.type.field", { fg = p.orange })

hl("@lsp.type.type", { fg = p.yellow })
hl("@lsp.type.interface", { fg = p.yellow })
hl("@lsp.type.class", { fg = p.yellow })
hl("@lsp.type.enum", { fg = p.yellow })
hl("@lsp.type.enumMember", { fg = p.yellow })

link("@lsp.typemod.variable.readonly", "Constant")
link("@lsp.typemod.property.readonly", "Constant")

-- Plugin: gitsigns
hl("GitSignsAdd", { fg = p.green })
hl("GitSignsChange", { fg = p.blue })
hl("GitSignsDelete", { fg = p.magenta })

-- Plugin: telescope
hl("TelescopeNormal", { fg = p.fg, bg = float_bg })
hl("TelescopeBorder", { fg = p.fg_muted, bg = float_bg })
hl("TelescopePromptNormal", { fg = p.fg, bg = float_bg })
hl("TelescopePromptBorder", { fg = p.fg_muted, bg = float_bg })
hl("TelescopeSelection", { fg = p.fg, bg = p.selection, bold = true })
hl("TelescopeMatching", { fg = p.blue, bold = true })
hl("TelescopeTitle", { fg = p.blue, bold = true })

-- Plugin: nvim-tree
hl("NvimTreeNormal", { fg = p.fg, bg = sidebar_bg })
hl("NvimTreeNormalNC", { fg = p.fg, bg = sidebar_bg })
hl("NvimTreeWinSeparator", { fg = p.border, bg = sidebar_bg })
hl("NvimTreeCursorLine", { bg = p.cursorline })
hl("NvimTreeFolderName", { fg = p.cyan })
hl("NvimTreeOpenedFolderName", { fg = p.cyan, bold = true })
hl("NvimTreeRootFolder", { fg = p.blue, bold = true })
hl("NvimTreeFolderIcon", { fg = p.cyan })
hl("NvimTreeSpecialFile", { fg = p.orange, italic = true })
hl("NvimTreeExecFile", { fg = p.green, bold = true })
hl("NvimTreeSymlink", { fg = p.blue })
hl("NvimTreeImageFile", { fg = p.fg })
hl("NvimTreeIndentMarker", { fg = p.fg_muted })
hl("NvimTreeGitNew", { fg = p.green })
hl("NvimTreeGitDirty", { fg = p.blue })
hl("NvimTreeGitDeleted", { fg = p.magenta })

-- Plugin: blink.cmp (and fallback to Cmp* for compatibility)
-- Base menu
hl("BlinkCmpMenu", { fg = p.fg, bg = float_bg })
hl("BlinkCmpMenuBorder", { fg = p.fg_muted, bg = float_bg })
hl("BlinkCmpScrollBar", { fg = p.fg_muted, bg = p.bg_dim })
hl("BlinkCmpMenuSelection", { fg = p.fg, bg = p.selection, bold = true })
-- Items
hl("BlinkCmpLabel", { fg = p.fg })
hl("BlinkCmpLabelDeprecated", { fg = p.fg_muted, strikethrough = true })
hl("BlinkCmpLabelMatch", { fg = p.blue, bold = true })
hl("BlinkCmpKind", { fg = p.fg_muted })
hl("BlinkCmpKindFunction", { fg = p.cyan })
hl("BlinkCmpKindMethod", { fg = p.cyan })
hl("BlinkCmpKindVariable", { fg = p.yellow })
hl("BlinkCmpKindField", { fg = p.orange })
hl("BlinkCmpKindProperty", { fg = p.orange })
hl("BlinkCmpKindClass", { fg = p.yellow })
hl("BlinkCmpKindInterface", { fg = p.yellow })
hl("BlinkCmpKindTypeParameter", { fg = p.yellow })
hl("BlinkCmpKindKeyword", { fg = p.magenta })
hl("BlinkCmpKindConstant", { fg = p.yellow })
hl("BlinkCmpKindSnippet", { fg = p.pink })

-- nvim-cmp fallback (if you ever switch)
hl("CmpItemAbbr", { fg = p.fg })
hl("CmpItemAbbrMatch", { fg = p.blue, bold = true })
hl("CmpItemAbbrMatchFuzzy", { fg = p.blue })
hl("CmpItemMenu", { fg = p.fg_muted })
hl("CmpItemKindFunction", { fg = p.cyan })
hl("CmpItemKindMethod", { fg = p.cyan })
hl("CmpItemKindVariable", { fg = p.yellow })
hl("CmpItemKindField", { fg = p.orange })
hl("CmpItemKindProperty", { fg = p.orange })
hl("CmpItemKindClass", { fg = p.yellow })
hl("CmpItemKindInterface", { fg = p.yellow })
hl("CmpItemKindTypeParameter", { fg = p.yellow })
hl("CmpItemKindKeyword", { fg = p.magenta })
hl("CmpItemKindSnippet", { fg = p.pink })
hl("CmpItemKindConstant", { fg = p.yellow })

-- Plugin: lspsaga (v0.3+ uses 'Saga*'; older used 'LspSaga*')
-- Float shells
hl("SagaNormal", { fg = p.fg, bg = float_bg })
hl("SagaBorder", { fg = p.fg_muted, bg = float_bg })
hl("SagaTitle", { fg = p.blue, bold = true })
-- Link legacy names
link("LspSagaNormal", "SagaNormal")
link("LspSagaBorder", "SagaBorder")
link("LspSagaTitle", "SagaTitle")

-- Code action / finder accents
hl("SagaFinderSelection", { fg = p.fg, bg = p.selection, bold = true })
hl("SagaVirtLine", { fg = p.border })
hl("SagaBeacon", { bg = p.selection })
hl("SagaLightBulb", { fg = p.yellow })

-- Brackets (rainbow-delimiters)
hl("RainbowDelimiterRed", { fg = p.magenta })
hl("RainbowDelimiterBlue", { fg = p.blue })
hl("RainbowDelimiterCyan", { fg = p.cyan })
hl("RainbowDelimiterYellow", { fg = p.yellow })
hl("RainbowDelimiterOrange", { fg = p.orange })
hl("RainbowDelimiterGreen", { fg = p.green })

-- Spell
hl("SpellBad", { sp = p.error, undercurl = true })
hl("SpellCap", { sp = p.info, undercurl = true })
hl("SpellLocal", { sp = p.info, undercurl = true })
hl("SpellRare", { sp = p.hint, undercurl = true })

-- Terminal palette
vim.g.terminal_color_0 = p.bg
vim.g.terminal_color_1 = p.error
vim.g.terminal_color_2 = p.green
vim.g.terminal_color_3 = p.yellow
vim.g.terminal_color_4 = p.teal
vim.g.terminal_color_5 = p.magenta
vim.g.terminal_color_6 = p.cyan
vim.g.terminal_color_7 = p.fg

vim.g.terminal_color_8 = p.fg_muted
vim.g.terminal_color_9 = p.pink
vim.g.terminal_color_10 = p.green
vim.g.terminal_color_11 = p.orange
vim.g.terminal_color_12 = p.blue
vim.g.terminal_color_13 = p.magenta
vim.g.terminal_color_14 = p.cyan
vim.g.terminal_color_15 = "#e6ebf2"
