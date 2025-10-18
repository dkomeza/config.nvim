return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          side = "right",     -- open on the right
          width = 40,         -- width of the tree
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        update_focused_file = {
          enable = true,       -- keeps tree focused on the current file
        },

	filters = {
    		dotfiles = false,          -- keep this if you want hidden dotfiles still visible
    		custom = { ".git" },       -- hide the .git folder
  	},
      })

      -- Toggle file explorer
      vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

      -- Focus on file explorer (open if closed)
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Focus File Explorer" })
    end,
  },
}

