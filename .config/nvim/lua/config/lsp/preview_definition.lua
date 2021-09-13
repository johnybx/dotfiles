local popup = require("plenary.popup")
local tconfig = require("telescope.config")
local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")

-- takes location from lsp
local function open_preview_window(location)
	local item = vim.lsp.util.locations_to_items({ location })[1]
	local border = tconfig.values["border"]
	local borderchars = tconfig.values["borderchars"]
	local max_lines = vim.o.lines - vim.o.cmdheight
	local max_columns = vim.o.columns
	local win_height = 0.8
	local win_width = 0.8
	local max_width = 160 -- TODO: how should be window positioned ? ¯\_(ツ)_/¯
	local winblend = 0

	-- TODO: max width if screen much wider than let's say 160 (ultrawide) and start further from the
	-- mouse to keep context
	local width = math.floor(max_columns * win_width)
	local preview_win, preview_opts = popup.create("", {
		title = "Preview: " .. item.filename,
		border = border,
		borderchars = borderchars,
		col = math.floor((max_columns * (1.0 - win_width)) / 2),
		line = math.floor((max_lines * (1.0 - win_height)) / 2),
		focusable = true,
		width = width < max_width and width or max_width,
		minheight = math.floor(max_lines * win_height),
		height = math.floor(max_lines * win_height),
	})
	local preview_border_win = preview_opts.border and preview_opts.border.win_id
	if preview_border_win then
		vim.api.nvim_win_set_option(preview_border_win, "winhl", "Normal:TelescopePromptBorder")
	end
	local preview_bufnr = vim.api.nvim_win_get_buf(preview_win)
	local function callback(...)
		vim.api.nvim_win_set_cursor(preview_win, { item.lnum, item.col })
		vim.cmd("norm! zz")
		pcall(vim.api.nvim_buf_set_option, preview_bufnr, "filetype", "CustomPreview")
		pcall(vim.api.nvim_buf_set_option, preview_bufnr, "readonly", true)
	end
	previewers.buffer_previewer_maker(item.filename, preview_bufnr, { callback = callback })
	if winblend then
		vim.api.nvim_win_set_option(preview_win, "winblend", winblend)
	end
	vim.api.nvim_buf_set_keymap(
		preview_bufnr,
		"n",
		"q",
		'<cmd>lua require("config.lsp.preview_definition").close(' .. preview_bufnr .. ")<CR>",
		{ noremap = true }
	)
end

-- shamelessly borrowed from telescope.nvim -> lua/telescope/builtin/lsp.lua list_or_jump
local function open(action, title, opts)
	opts = opts or {}

	local params = vim.lsp.util.make_position_params()
	local result, err = vim.lsp.buf_request_sync(0, action, params, opts.timeout or 10000)
	if err then
		vim.api.nvim_err_writeln("Error when executing " .. action .. " : " .. err)
		return
	end
	local flattened_results = {}
	for _, server_results in pairs(result) do
		if server_results.result then
			-- textDocument/definition can return Location or Location[]
			if not vim.tbl_islist(server_results.result) then
				flattened_results = { server_results.result }
				break
			end

			vim.list_extend(flattened_results, server_results.result)
		end
	end

	if #flattened_results == 0 then
		vim.api.nvim_err_writeln("No result from executing " .. action)
		return
	elseif #flattened_results == 1 then
		open_preview_window(flattened_results[1])
	else
		local locations = vim.lsp.util.locations_to_items(flattened_results)
		pickers.new(opts, {
			prompt_title = title,
			finder = finders.new_table({
				results = locations,
				entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
			}),
			previewer = tconfig.values.qflist_previewer(opts),
			sorter = tconfig.values.generic_sorter(opts),
		}):find()
	end
end

-- close floating preview buffer
-- NOTE: popup.create adds autocmd for BufDelete to close windows so it is enough to delete buffer
local function close(bufnr)
	if vim.api.nvim_buf_is_valid(bufnr) then
		vim.cmd("bdelete " .. bufnr)
	end
end

local M = {
	open = open,
	close = close,
}

return M
