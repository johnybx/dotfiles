local popup = require("plenary.popup")
local window = require("plenary.window")
local tconfig = require("telescope.config")
local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local entry_display = require("telescope.pickers.entry_display")
local utils = require("telescope.utils")
local transform_mod = require("telescope.actions.mt").transform_mod
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local state = {}
local module_name = "config.lsp.preview_definition"

-- takes location from lsp
local function open_preview_window(location)
    local item = vim.lsp.util.locations_to_items({ location }, location.offset_encoding)[1]
    local border = tconfig.values["border"]
    local borderchars = tconfig.values["borderchars"]
    local max_lines = vim.o.lines - vim.o.cmdheight
    local max_columns = vim.o.columns
    local win_height = 0.8
    local win_width = 0.8
    local max_width = 160 -- TODO: how should be window positioned ? ¯\_(ツ)_/¯
    local winblend = 0
    local initial_window = vim.api.nvim_get_current_win()

    -- TODO: max width if screen much wider than let's say 160 (ultrawide) and start further from the
    -- mouse to keep context
    local width = math.floor(max_columns * win_width)
    local preview_win, preview_opts = popup.create("", {
        title = "Preview: " .. vim.fn.fnamemodify(item.filename, ":."),
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
    pcall(vim.api.nvim_buf_set_option, preview_bufnr, "undolevels", -1)

    state[preview_win] = {
        preview_bufnr = preview_bufnr,
        location = location,
        initial_window = initial_window,
        preview_border_win_id = preview_border_win,
    }

    local function callback(...)
        vim.api.nvim_win_set_cursor(preview_win, { item.lnum, item.col })
        vim.cmd("norm! zz")
        pcall(vim.api.nvim_buf_set_option, preview_bufnr, "filetype", "CustomPreview")
        pcall(vim.api.nvim_buf_set_option, preview_bufnr, "readonly", true)
        pcall(vim.api.nvim_buf_set_option, preview_bufnr, "undolevels", 1000)
    end
    previewers.buffer_previewer_maker(item.filename, preview_bufnr, { callback = callback })
    if winblend then
        vim.api.nvim_win_set_option(preview_win, "winblend", winblend)
    end
    vim.cmd(
        string.format(
            [[ autocmd BufLeave <buffer=%s> ++once ++nested lua require("%s").close(%s) ]],
            preview_bufnr,
            module_name,
            preview_win
        )
    )
    vim.api.nvim_buf_set_keymap(
        preview_bufnr,
        "n",
        "q",
        '<cmd>lua require("' .. module_name .. '").close(' .. preview_win .. ")<CR>",
        { noremap = true }
    )
    vim.api.nvim_buf_set_keymap(
        preview_bufnr,
        "n",
        "<C-v>",
        '<cmd>lua require("' .. module_name .. '").jump(' .. preview_win .. ', "vsplit")<CR>',
        { noremap = true }
    )
    vim.api.nvim_buf_set_keymap(
        preview_bufnr,
        "n",
        "<C-s>",
        '<cmd>lua require("' .. module_name .. '").jump(' .. preview_win .. ', "split")<CR>',
        { noremap = true }
    )
    vim.api.nvim_buf_set_keymap(
        preview_bufnr,
        "n",
        "<C-t>",
        '<cmd>lua require("' .. module_name .. '").jump(' .. preview_win .. ', "tab")<CR>',
        { noremap = true }
    )
    vim.api.nvim_buf_set_keymap(
        preview_bufnr,
        "n",
        "<CR>",
        '<cmd>lua require("' .. module_name .. '").jump(' .. preview_win .. ", nil)<CR>",
        { noremap = true }
    )
end

local custom_actions = transform_mod({
    select_float = function(prompt_bufnr)
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        open_preview_window(selection.location)
    end,
})

local function attach_mappings(prompt_bufnr, map)
    local mappings = {
        i = {
            ["<CR>"] = custom_actions.select_float,
        },
        n = {
            ["<CR>"] = custom_actions.select_float,
        },
    }

    for mode, mode_mappings in pairs(mappings) do
        for key, func in pairs(mode_mappings) do
            map(mode, key, func)
        end
    end
    -- actions.select_default:replace(function()
    -- 	actions.close(prompt_bufnr)
    -- 	local selection = action_state.get_selected_entry()
    -- 	open_preview_window(selection.location)
    -- end)

    return true
end

local function entry_from_location(opts)
    opts = opts or {}

    local displayer = entry_display.create({
        separator = "▏",
        items = {
            { width = 8 },
            { width = 50 },
            { remaining = true },
        },
    })

    local make_display = function(entry)
        local filename = utils.transform_path(opts, entry.filename)

        local line_info = { table.concat({ entry.lnum, entry.col }, ":"), "TelescopeResultsLineNr" }

        return displayer({
            line_info,
            entry.text:gsub(".* | ", ""),
            filename,
        })
    end

    return function(location)
        local entry = vim.lsp.util.locations_to_items({ location }, location.offset_encoding)[1]
        return {
            valid = true,

            value = entry,
            ordinal = (not opts.ignore_filename and entry.filename or "") .. " " .. entry.text,
            display = make_display,

            bufnr = entry.bufnr,
            filename = entry.filename,
            lnum = entry.lnum,
            col = entry.col,
            text = entry.text,
            start = entry.start,
            finish = entry.finish,
            location = location,
        }
    end
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
    for client_id, server_results in pairs(result) do
        if server_results.result then
            -- This need to be suppied to every locations_to_items call.
            local offset_encoding = vim.lsp.get_client_by_id(client_id).offset_encoding
            -- textDocument/definition can return Location or Location[]
            if not vim.tbl_islist(server_results.result) then
                server_results.result.offset_encoding = offset_encoding
                vim.list_extend(flattened_results, { server_results.result })
            else
                for _, s_result in ipairs(server_results.result) do
                    s_result.offset_encoding = offset_encoding
                end
                vim.list_extend(flattened_results, server_results.result)
            end
        end
    end

    if #flattened_results == 0 then
        vim.api.nvim_err_writeln("No result from executing " .. action)
        return
    elseif #flattened_results == 1 then
        open_preview_window(flattened_results[1])
    else
        pickers.new(opts, {
            prompt_title = title,
            finder = finders.new_table({
                results = flattened_results,
                entry_maker = opts.entry_maker or entry_from_location(opts),
            }),
            previewer = tconfig.values.qflist_previewer(opts),
            sorter = tconfig.values.generic_sorter(opts),
            attach_mappings = attach_mappings,
        }):find()
    end
end

-- close floating preview buffer
-- NOTE: popup.create adds autocmd for BufDelete to close windows so it is enough to delete buffer
local function close(preview_win)
    if state[preview_win] == nil then
        return
    end

    local bufnr = state[preview_win].preview_bufnr
    local preview_border_win_id = state[preview_win].preview_border_win_id
    state[preview_win] = nil

    if vim.api.nvim_buf_is_valid(bufnr) then
        vim.cmd("bdelete " .. bufnr)
    end
    -- preview border win is not closed when buffer in preview win is closed ¯\_(ツ)_/¯
    if
        (preview_border_win_id and vim.api.nvim_win_is_valid(preview_border_win_id))
        or vim.api.nvim_win_is_valid(preview_win)
    then
        window.close_related_win(preview_win, preview_border_win_id)
    end
end

-- jump_type can be nil to open in window
local function jump(preview_win, jump_type)
    local location = state[preview_win].location
    local initial_window = state[preview_win].initial_window

    close(preview_win)

    if vim.api.nvim_win_is_valid(initial_window) then
        vim.api.nvim_set_current_win(initial_window)
    end

    if jump_type == "tab" then
        vim.cmd("tabedit")
    elseif jump_type == "split" then
        vim.cmd("new")
    elseif jump_type == "vsplit" then
        vim.cmd("vnew")
    end

    vim.lsp.util.jump_to_location(location, location.offset_encoding)
end

local M = {
    open = open,
    jump = jump,
    close = close,
}

return M
