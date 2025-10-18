return {
	'Mohammed-Taher/AdvancedNewFile.nvim',
	config = function()
		vim.keymap.set("n", "<leader>N", "<cmd>AdvancedNewFile<CR>", { desc = "Create new file" })
	end,
}
