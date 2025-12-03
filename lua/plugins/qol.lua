return {
	-- Autopairs: automatically close brackets, quotes, etc.
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- -- Surround: easily manipulate surrounding brackets, quotes, tags
	-- {
	--   "kylechui/nvim-surround",
	--   config = function()
	--     require("nvim-surround").setup({})
	--   end,
	-- },

	-- Commenting: toggle comments easily
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = {
					line = "<leader>/", -- toggle line comment
					block = "<leader>\\", -- toggle block comment (optional)
				},
				opleader = {
					line = "<leader>/",
					block = "<leader>\\",
				},
			})
		end,
	},
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
	},
}
