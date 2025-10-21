return {
	{
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		-- log_level = 'debug',
	},
	-- config = function()
	-- 	vim.api.nvim_create_user_command("Qq", function()
	-- 		require("auto-session").SaveSession()
	-- 		vim.cmd("qa")
	-- 	end, { nargs = 0 })
	-- 	vim.cmd.cnoreabbrev("qq", "Qq")
	-- end,
}
}
