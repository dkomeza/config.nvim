return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<leader>t]], -- ⌘+J (Mac) — opens or focuses the terminal
				direction = "horizontal", -- You can change to 'float' or 'vertical'
				shade_terminals = true,
				start_in_insert = true,
				insert_mappings = false,
			})

			local Terminal = require("toggleterm.terminal").Terminal
			local main_term = Terminal:new({ hidden = true, direction = "horizontal" })

			-- Focus or open terminal
			-- vim.keymap.set({ "n", "t" }, "<leader>j", function()
			--   if main_term:is_open() then
			--     main_term:focus()
			--   else
			--     main_term:open()
			--   end
			-- end, { desc = "Focus or open terminal" })

			-- Toggle terminal visibility
			vim.keymap.set({ "n", "t" }, "<leader>t", function()
				main_term:toggle()
			end, { desc = "Toggle terminal" })
		end,
	},
}
