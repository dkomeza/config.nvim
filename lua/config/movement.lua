vim.keymap.set("n", "h", function()
	local col = vim.fn.col(".")
	if col == 1 then
		-- If we're at the start of the line, go to the previous line's end
		if vim.fn.line(".") > 1 then
			vim.cmd("normal! k$")
		end
	else
		-- Otherwise behave normally
		vim.cmd("normal! h")
	end
end, { noremap = true, silent = true })
