return {{
  dir = "~/.config/nvim/lua",
  name = "snf",
  config = function()
	vim.keymap.set("n", "<leader>N", function()
  require("snf").create_file()
end, { desc = "Create file (project root)" })

vim.keymap.set("n", "<leader>n", function()
  require("snf").create_file_relative()
end, { desc = "Create file (relative to current)" })
end,
}}


