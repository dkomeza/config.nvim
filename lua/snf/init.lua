local api = vim.api
local Path = require("plenary.path")
local scandir = require("plenary.scandir")

local M = {}

local state = {
	buf = nil,
	win = nil,
	input_buf = nil,
	input_win = nil,
	base_dir = nil,
}

local has_devicons, devicons = pcall(require, "nvim-web-devicons")

local function get_icon(name, is_dir)
	if not has_devicons then
		return is_dir and " " or " ", ""
	end

	if is_dir then
		return devicons.get_icon(name, nil, { default = true })
	end

	local icon, hl = devicons.get_icon(name, nil, { default = true })
	return icon or "", hl or ""
end

local function get_current_dir()
	local current_file = vim.fn.expand("%:p")
	if current_file == "" then
		return vim.fn.getcwd()
	end
	return vim.fn.fnamemodify(current_file, ":h")
end

local function get_directory_contents(dir_path)
	local path = Path:new(dir_path)
	if not path:exists() then
		return {}
	end

	local results = {}
	pcall(function()
		local scan_results = scandir.scan_dir(dir_path, {
			depth = 1,
			add_dirs = true,
			silent = true,
		})

		for _, file in ipairs(scan_results) do
			local relative = file:sub(#dir_path + 2)
			if relative ~= "" then
				local is_dir = Path:new(file):is_dir()
				table.insert(results, {
					name = relative,
					path = file,
					is_dir = is_dir,
				})
			end
		end
	end)

	table.sort(results, function(a, b)
		if a.is_dir ~= b.is_dir then
			return a.is_dir
		end
		return a.name < b.name
	end)

	return results
end

local function insert_new_entry(contents, new_entry)
	local inserted = false
	for i, item in ipairs(contents) do
		if new_entry.is_dir and not item.is_dir then
			table.insert(contents, i, new_entry)
			inserted = true
			break
		elseif new_entry.is_dir == item.is_dir and new_entry.name < item.name then
			table.insert(contents, i, new_entry)
			inserted = true
			break
		end
	end

	if not inserted then
		table.insert(contents, new_entry)
	end

	return contents
end

local function update_display(input_text)
	if not state.buf or not api.nvim_buf_is_valid(state.buf) then
		return
	end

	local full_path = state.base_dir .. "/" .. input_text
	local dir_path, filename, is_new_dir

	-- Check if input ends with / (navigating or creating a directory)
	if input_text:match("/$") then
		local dir_full_path = full_path:sub(1, -2)
		local dir_exists = Path:new(dir_full_path):exists()

		if dir_exists then
			-- Navigate into existing directory
			dir_path = dir_full_path
			filename = ""
			is_new_dir = false
		else
			-- Show as new directory in parent
			dir_path = vim.fn.fnamemodify(dir_full_path, ":h")
			filename = vim.fn.fnamemodify(dir_full_path, ":t")
			is_new_dir = true
		end
	else
		-- Check if there's a / and content after it
		local last_slash = input_text:match("^.*/()")
		if last_slash and last_slash <= #input_text then
			-- There's content after the last slash, navigate into directory
			dir_path = vim.fn.fnamemodify(full_path, ":h")
			filename = vim.fn.fnamemodify(full_path, ":t")
			is_new_dir = false
		else
			-- No slash or only slash, stay in base directory
			dir_path = state.base_dir
			filename = input_text
			is_new_dir = false
		end
	end

	local contents = get_directory_contents(dir_path)
	local lines = {}
	local highlights = {}

	local display_dir = dir_path:sub(#state.base_dir + 2)
	if display_dir == "" then
		display_dir = "."
	end

	table.insert(lines, "Directory: " .. display_dir)
	table.insert(lines, "")

	-- Insert the new file/folder in the correct position
	if filename ~= "" and filename ~= "." then
		local new_entry = {
			name = filename,
			is_dir = is_new_dir,
			is_new = true,
		}
		contents = insert_new_entry(contents, new_entry)
	end

	for _, item in ipairs(contents) do
		local icon, icon_hl = get_icon(item.name, item.is_dir)
		local suffix = item.is_dir and "/" or ""
		local new_marker = item.is_new and " [NEW]" or ""

		local line = "  " .. icon .. " " .. item.name .. suffix .. new_marker
		table.insert(lines, line)

		if item.is_new then
			table.insert(highlights, {
				line = #lines - 1,
				col_start = 0,
				col_end = -1,
				hl_group = "TelescopeSelection",
			})
		end

		if icon_hl and icon_hl ~= "" then
			local icon_start = 2
			local icon_end = icon_start + #icon
			table.insert(highlights, {
				line = #lines - 1,
				col_start = icon_start,
				col_end = icon_end,
				hl_group = icon_hl,
			})
		end
	end

	api.nvim_buf_set_option(state.buf, "modifiable", true)
	api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
	api.nvim_buf_set_option(state.buf, "modifiable", false)

	local ns_id = api.nvim_create_namespace("create_file")
	api.nvim_buf_clear_namespace(state.buf, ns_id, 0, -1)

	for _, hl in ipairs(highlights) do
		api.nvim_buf_add_highlight(state.buf, ns_id, hl.hl_group, hl.line, hl.col_start, hl.col_end)
	end
end

local function create_file_with_dirs(filepath)
	local path = Path:new(filepath)
	local parent = path:parent()

	if not parent:exists() then
		parent:mkdir({ parents = true })
		vim.notify("Created directories: " .. parent:absolute(), vim.log.levels.INFO)
	end

	if path:exists() then
		vim.notify("File already exists: " .. filepath, vim.log.levels.WARN)
		vim.cmd("edit " .. vim.fn.fnameescape(filepath))
		return
	end

	path:touch({ parents = true })
	vim.notify("Created file: " .. filepath, vim.log.levels.INFO)
	vim.cmd("edit " .. vim.fn.fnameescape(filepath))
end

local function close_ui()
	if state.win and api.nvim_win_is_valid(state.win) then
		api.nvim_win_close(state.win, true)
	end
	if state.input_win and api.nvim_win_is_valid(state.input_win) then
		api.nvim_win_close(state.input_win, true)
	end
	vim.cmd("stopinsert")
end

local function create_ui(base_dir)
	state.base_dir = base_dir

	local width = 100
	local height = 30
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	state.buf = api.nvim_create_buf(false, true)
	state.input_buf = api.nvim_create_buf(false, true)

	api.nvim_buf_set_option(state.buf, "bufhidden", "wipe")
	api.nvim_buf_set_option(state.input_buf, "bufhidden", "wipe")

	state.win = api.nvim_open_win(state.buf, false, {
		relative = "editor",
		width = width,
		height = height - 3,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Create File: " .. base_dir .. " ",
		title_pos = "center",
	})

	state.input_win = api.nvim_open_win(state.input_buf, true, {
		relative = "editor",
		width = width,
		height = 1,
		row = row + height - 2,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	api.nvim_buf_set_option(state.buf, "modifiable", false)

	api.nvim_buf_set_keymap(state.input_buf, "i", "<CR>", "", {
		callback = function()
			local input = api.nvim_buf_get_lines(state.input_buf, 0, 1, false)[1]
			close_ui()
			if input and input ~= "" then
				local full_path = state.base_dir .. "/" .. input
				-- Remove trailing slash for file creation
				if full_path:match("/$") then
					full_path = full_path:sub(1, -2)
				end
				create_file_with_dirs(full_path)
			end
		end,
		noremap = true,
	})

	api.nvim_buf_set_keymap(state.input_buf, "i", "<Esc>", "", {
		callback = close_ui,
		noremap = true,
	})

	api.nvim_buf_set_keymap(state.input_buf, "n", "<Esc>", "", {
		callback = close_ui,
		noremap = true,
	})

	api.nvim_create_autocmd("TextChangedI", {
		buffer = state.input_buf,
		callback = function()
			local input = api.nvim_buf_get_lines(state.input_buf, 0, 1, false)[1]
			update_display(input or "")
		end,
	})

	vim.cmd("startinsert")
	update_display("")
end

function M.create_file(prefill)
	local base_dir = prefill or vim.fn.getcwd()
	create_ui(base_dir)
end

function M.create_file_relative()
	M.create_file(get_current_dir())
end

return M
