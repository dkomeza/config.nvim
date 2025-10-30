local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local sorters = require("telescope.sorters")

local M = {}

-- Smart files picker: recent files first, then the rest alphabetically
M.smart_files = function(opts)
  opts = opts or {}

  -- Use the folder of the currently open file as cwd
  local cwd = vim.fn.expand("%:p:h")

  -- Recent files filtered to current cwd
  local recent_files = {}
  for _, f in ipairs(vim.v.oldfiles or {}) do
    if f:match("^" .. cwd) then
      table.insert(recent_files, f)
    end
  end

  -- All files in current cwd using fd
  local handle = io.popen('fd --type f --hidden --follow --exclude .git "" "' .. cwd .. '"')
  local all_files = {}
  if handle then
    for line in handle:lines() do
      table.insert(all_files, line)
    end
    handle:close()
  end

  -- Combine recent + all files, remove duplicates
  local seen = {}
  local combined = {}
  for _, f in ipairs(recent_files) do
    if not seen[f] then
      table.insert(combined, f)
      seen[f] = true
    end
  end
  for _, f in ipairs(all_files) do
    if not seen[f] then
      table.insert(combined, f)
      seen[f] = true
    end
  end

  pickers.new(opts, {
    prompt_title = "Smart Files",
    finder = finders.new_table {
      results = combined
    },
    sorter = sorters.get_fzy_sorter(),
  }):find()
end

return M
