return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local telescope = require("telescope")

      -- Setup with optional enhancements
      telescope.setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = " ",
          path_display = { "smart" },
          mappings = {
            i = {
              ["<Esc>"] = actions.close,  -- single Esc closes Telescope in insert mode
            },
            n = {
              ["<Esc>"] = actions.close,  -- single Esc closes Telescope in normal mode
            },
          },
        },
      })

      local builtin = require("telescope.builtin")
      -- Cmd+P style "Quick Open"
      vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Find Files" })
	
    -- Search inside files (like VSCode global search / Cmd+Shift+F)
      vim.keymap.set("n", "<leader>P", builtin.live_grep, { desc = "Search Inside Files" })
      end,
  },
}

