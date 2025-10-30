return {
	{
		"rcasia/neotest-java",
		ft = "java",
		dependencies = {
			"mfussenegger/nvim-jdtls",
			"mfussenegger/nvim-dap", -- for the debugger
			"rcarriga/nvim-dap-ui", -- recommended
			"theHamsta/nvim-dap-virtual-text", -- recommended
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-java")({
						-- config here
					}),
				},
			})

			-- Now define keymaps
			local map = vim.keymap.set
			local opts = { noremap = true, silent = true, desc = "Neotest" }

			-- Run test file
			map("n", "<leader>tt", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, opts)

			-- Run nearest test
			map("n", "<leader>tr", function()
				require("neotest").run.run()
			end, opts)

			-- Debug test file
			map("n", "<leader>tD", function()
				require("neotest").run.run({ strategy = "dap" })
			end, opts)

			-- Debug nearest test
			map("n", "<leader>td", function()
				require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
			end, opts)
		end,
	},
}
