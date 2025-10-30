local colors = {
	bg = "#0E131B",
	fg = "#c8d1df",
	accent = "#88abf9",
	green = "#98c379",
	yellow = "#e8c37d",
	pink = "#f386bf",
}

local groups = {
	Normal = { fg = colors.fg, bg = colors.bg },
	Comment = { fg = "#b38098", italic = true },
	Keyword = { fg = "#ba7bcc" },
	String = { fg = colors.green },
	Function = { fg = "#53c6ba" },
	Type = { fg = "#e8c37d" },
}

for group, opts in pairs(groups) do
	vim.api.nvim_set_hl(0, group, opts)
end
