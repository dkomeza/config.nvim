-- Enable automatic write when switching buffers or running certain commands
vim.opt.autowriteall = true

-- Automatically save files on insert leave or text change (if modifiable and not readonly)
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "TextChangedP" }, {
	pattern = "*",
	callback = function()
		if vim.bo.modifiable and not vim.bo.readonly then
			-- Format the buffer if any LSP attached supports it
			-- if #vim.lsp.buf_get_clients() > 0 then
			-- 	-- Async format
			-- 	vim.lsp.buf.format({
			-- 		async = true,
			-- 		timeout_ms = 1000,
			-- 	})
			-- end

			vim.cmd("silent! update")

			-- Notify rust-analyzer that the file was saved
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			for _, client in ipairs(clients) do
				if client.name == "rust_analyzer" then
					client.notify("textDocument/didSave", {
						textDocument = { uri = vim.uri_from_bufnr(0) },
					})
				end
			end

			-- Short-lived autosave notification
			vim.notify("💾 Autosaved " .. vim.fn.expand("%:t"), vim.log.levels.INFO, {
				title = "AutoSave",
				timeout = 500, -- 0.5 seconds
				render = "minimal",
				stages = "static",
			})
		end
	end,
})
