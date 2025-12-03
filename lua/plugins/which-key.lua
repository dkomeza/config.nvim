return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
		},
		-- key labels (optional)
		key_labels = {
			["<space>"] = "SPC",
			["<leader>"] = "LEADER",
		},
		window = {
			border = "rounded",
			margin = { 1, 0, 1, 0 },
			padding = { 2, 2, 2, 2 },
		},
		layout = {
			spacing = 6,
			align = "center",
		},
	},
}
