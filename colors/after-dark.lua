-- After Dark colorscheme for Neovim (Tree-sitter + LSP)
-- Inspired by VS Code theme you provided
-- Place this file at: ~/.config/nvim/colors/afterdark.lua
-- Then :colorscheme afterdark

local opt = vim.g.afterdark_config or {}

-- Options (override via vim.g.afterdark_config = { ... } before colorscheme)
local cfg = {
  transparent = opt.transparent or false,
  italic_comments = opt.italic_comments or false,
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
}

-- Helper
local function hl(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end
local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to })
end

-- Base
vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("hi clear " .. vim.g.colors_name)
end
vim.g.colors_name = "afterdark"

local bg = cfg.transparent and "NONE" or p.bg
local float_bg = cfg.transparent and "NONE" or p.bg
local popup_bg = cfg.transparent and "NONE" or p.bg
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

hl("Pmenu", { fg = p.fg, bg = popup_bg })
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

hl("DiffAdd", { fg = p.green, bg = "NONE", reverse = false })
hl("DiffChange", { fg = p.blue, bg = "NONE", reverse = false })
hl("DiffDelete", { fg = p.magenta, bg = "NONE", reverse = false })
hl("DiffText", { fg = p.blue, bg = p.bg_dim, bold = true })

hl("Directory", { fg = p.cyan })
hl("Title", { fg = p.green, bold = true })
hl("ErrorMsg", { fg = p.error, bold = true })
hl("WarningMsg", { fg = p.warn, bold = true })
hl("MoreMsg", { fg = p.green, bold = true })
hl("Question", { fg = p.green, bold = true })

-- Standard syntax
hl("Comment", {
  fg = "#b38098",
  italic = cfg.italic_comments and true or false,
})
hl("Constant", { fg = p.yellow })
hl("String", { fg = p.green })
hl("Character", { fg = p.green })
hl("Number", { fg = p.yellow })
hl("Boolean", { fg = p.yellow })
hl("Float", { fg = p.yellow })

hl("Identifier", { fg = p.blue })
hl("Function", { fg = p.cyan })

hl("Statement", {
  fg = p.magenta,
  italic = cfg.italic_keywords and true or false,
})
hl("Conditional", {
  fg = p.magenta,
  italic = cfg.italic_keywords and true or false,
})
hl("Repeat", {
  fg = p.magenta,
  italic = cfg.italic_keywords and true or false,
})
hl("Label", { fg = p.orange })
hl("Operator", { fg = p.magenta })
hl("Keyword", {
  fg = p.magenta,
  italic = cfg.italic_keywords and true or false,
})
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
hl("SpecialComment", { fg = "#b38098" })
hl("Debug", { fg = p.magenta })

hl("Todo", { fg = p.bg, bg = p.yellow, bold = true })
hl("Underlined", { underline = true })
hl("Bold", { bold = true })
hl("Italic", { italic = true })

-- Diagnostics (from your editor* colors)
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

-- Tree-sitter core
-- Base tokens (fallback when no semantic tokens)
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
hl("@variable.builtin", { fg = p.fg })
hl("@variable.member", { fg = p.orange }) -- properties/fields
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
hl("@keyword", {
  fg = p.magenta,
  italic = cfg.italic_keywords and true or false,
 })
hl("@keyword.operator", { fg = p.magenta })
hl("@keyword.return", { fg = p.magenta })
hl("@conditional", { fg = p.magenta })
hl("@repeat", { fg = p.magenta })
hl("@exception", { fg = p.pink })

hl("@tag", { fg = p.cyan })
hl("@tag.delimiter", { fg = p.fg_muted })
hl("@tag.attribute", { fg = p.orange })

-- LSP semantic tokens (override base when enabled)
-- You had:
--  function: #53c6ba, variable/parameter/type/interface: #e8c37d,
--  property: #E6A26F
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

-- Optionally refine typemods, e.g. readonly variables as constants
link("@lsp.typemod.variable.readonly", "Constant")
link("@lsp.typemod.property.readonly", "Constant")

-- UI accents matching your theme
hl("Search", { fg = p.fg, bg = p.selection })
hl("IncSearch", { fg = p.bg, bg = p.pink, bold = true })
hl("Visual", { bg = p.selection })
hl("CursorLine", { bg = p.cursorline })
hl("ColorColumn", { bg = p.bg_dim })

-- Git (gitsigns)
hl("GitSignsAdd", { fg = p.green })
hl("GitSignsChange", { fg = p.blue })
hl("GitSignsDelete", { fg = p.magenta })

-- Telescope
hl("TelescopeNormal", { fg = p.fg, bg = float_bg })
hl("TelescopeBorder", { fg = p.fg_muted, bg = float_bg })
hl("TelescopePromptNormal", { fg = p.fg, bg = float_bg })
hl("TelescopePromptBorder", { fg = p.fg_muted, bg = float_bg })
hl("TelescopeSelection", { fg = p.fg, bg = p.selection, bold = true })
hl("TelescopeMatching", { fg = p.blue, bold = true })
hl("TelescopeTitle", { fg = p.blue, bold = true })

-- nvim-cmp
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

-- Trees / files
hl("Directory", { fg = p.cyan })

-- Spell
hl("SpellBad", { sp = p.error, undercurl = true })
hl("SpellCap", { sp = p.info, undercurl = true })
hl("SpellLocal", { sp = p.info, undercurl = true })
hl("SpellRare", { sp = p.hint, undercurl = true })

-- Bracket colors (approx VS Code bracket highlight)
hl("RainbowDelimiterRed", { fg = p.magenta })
hl("RainbowDelimiterBlue", { fg = p.blue })
hl("RainbowDelimiterCyan", { fg = p.cyan })
hl("RainbowDelimiterYellow", { fg = p.yellow })

-- Terminal palette (from your terminal.* and theme)
vim.g.terminal_color_0 = p.bg      -- black
vim.g.terminal_color_1 = p.error   -- red
vim.g.terminal_color_2 = p.green   -- green
vim.g.terminal_color_3 = p.yellow  -- yellow
vim.g.terminal_color_4 = p.teal    -- blueish (your ansiBlue)
vim.g.terminal_color_5 = p.magenta -- magenta
vim.g.terminal_color_6 = p.cyan    -- cyan
vim.g.terminal_color_7 = p.fg      -- white

vim.g.terminal_color_8 = p.fg_muted
vim.g.terminal_color_9 = p.pink
vim.g.terminal_color_10 = p.green
vim.g.terminal_color_11 = p.orange
vim.g.terminal_color_12 = p.blue
vim.g.terminal_color_13 = p.magenta
vim.g.terminal_color_14 = p.cyan
vim.g.terminal_color_15 = "#e6ebf2"
