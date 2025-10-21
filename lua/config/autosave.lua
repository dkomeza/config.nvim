-- Enable automatic write when switching buffers or running certain commands
vim.opt.autowriteall = true

-- Automatically save files on insert leave or text change (if modifiable and not readonly)
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "TextChangedP" }, {
	pattern = "*",
	callback = function()
		if vim.bo.modifiable and not vim.bo.readonly then
			vim.cmd("silent! update")
		end
	end,
})
