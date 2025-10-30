return {
	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			vim.opt.termguicolors = true
			notify.setup({
				stages = "fade_in_slide_out", -- smooth animations
				timeout = 1500, -- how long notifications stay visible
				background_colour = "#000000", -- background color for transparency
				render = "default", -- could be "compact", "minimal", or "wrapped-compact"
				max_width = 60,
				max_height = 10,
				fps = 60,
			})

			-- Use notify as Neovim’s default notification handler
			vim.notify = notify
		end,
	},
}
