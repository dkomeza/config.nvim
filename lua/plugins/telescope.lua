return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					path_display = { "smart" },
				},
			})

			local builtin = require("telescope.builtin")

			-- Find files
			vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Find Files" })

			-- Live grep
			vim.keymap.set("n", "<leader>P", builtin.live_grep, { desc = "Search Inside Files" })

			
		end,
	},
}
