-- Lualine theme for After Dark
local p = {
  bg = "#0E131B",
  bg_alt = "#111722",
  fg = "#c8d1df",
  fg_muted = "#6c8093",
  blue = "#88abf9",
  cyan = "#53c6ba",
  magenta = "#ba7bcc",
  pink = "#f386bf",
  yellow = "#e8c37d",
  green = "#98c379",
  orange = "#E6A26F",
}

return {
  normal = {
    a = { fg = p.bg, bg = p.blue, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_alt },
    c = { fg = p.fg, bg = p.bg },
  },
  insert = {
    a = { fg = p.bg, bg = p.cyan, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_alt },
    c = { fg = p.fg, bg = p.bg },
  },
  visual = {
    a = { fg = p.bg, bg = p.pink, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_alt },
    c = { fg = p.fg, bg = p.bg },
  },
  replace = {
    a = { fg = p.bg, bg = p.orange, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_alt },
    c = { fg = p.fg, bg = p.bg },
  },
  command = {
    a = { fg = p.bg, bg = p.yellow, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_alt },
    c = { fg = p.fg, bg = p.bg },
  },
  inactive = {
    a = { fg = p.fg_muted, bg = p.bg_alt, gui = "bold" },
    b = { fg = p.fg_muted, bg = p.bg_alt },
    c = { fg = p.fg_muted, bg = p.bg },
  },
}
