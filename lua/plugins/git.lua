return {
	-- Git signs in the gutter
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true, -- show inline blame
				-- Optional: toggle blame with <leader>gb
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					vim.keymap.set(
						"n",
						"<leader>gb",
						gs.toggle_current_line_blame,
						{ buffer = bufnr, desc = "Toggle Blame" }
					)
				end,
			})
		end,
	},

	-- Optional: Git commands inside Neovim
	-- {
	-- 	"tpope/vim-fugitive",
	-- },
}
