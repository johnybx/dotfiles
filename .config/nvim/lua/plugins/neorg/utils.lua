local M = {}

local function split_norg_extension(filename)
    for _, part in ipairs(vim.split(filename, ".", { plain = true })) do
        return part
    end
end

local function process_folder(folder_tree, current_path, heading_level)
    local result = ""
    if not folder_tree then
        return result
    end

    local sep = require("plenary.path").path.sep

    table.sort(folder_tree, function(a, b)
        local index_file = "index.norg"
        if a == index_file then
            return true
        elseif b == index_file then
            return false
        end
        return #a < #b
    end)

    -- process files first
    for _, file in ipairs(folder_tree) do
        file = split_norg_extension(file)
        result = result .. "  - {:" .. current_path .. file .. ":}[" .. file .. "]\n"
    end
    result = result .. "\n"

    local sorted_folders = {}
    for folder, value in pairs(folder_tree) do
        if type(value) == "table" then
            table.insert(sorted_folders, folder)
        end
    end
    table.sort(sorted_folders)

    heading_level = heading_level .. "*"
    for _, folder in ipairs(sorted_folders) do
        local sub_folder = folder_tree[folder]
        result = result .. heading_level .. " " .. folder .. "\n"
        result = result .. process_folder(sub_folder, current_path .. folder .. sep, heading_level)
    end

    if string.sub(result, -2) ~= "\n\n" then
        result = result .. "\n"
    end

    return result
end

function M.generate_dir_contents()
    local dir = vim.fn.expand("%:p:h")
    local files = require("plenary.scandir").scan_dir(dir)
    local sep = require("plenary.path").path.sep
    local folder_tree = {}
    for _, path in ipairs(files) do
        local current = folder_tree
        path = string.sub(path, #dir + 1)
        local parts = vim.split(path, sep, { trimempty = true, plain = true })
        for i, part in ipairs(parts) do
            if i == #parts then
                table.insert(current, part)
            else
                if not current[part] then
                    current[part] = {}
                end
                current = current[part]
            end
        end
    end
    local heading = "* Directory contents"
    local current_path = ""
    local heading_level = "*"
    local result = heading .. "\n" .. process_folder(folder_tree, current_path, heading_level)
    local delimiter = "-------------------------"
    result = result .. delimiter .. "\n"
    local line = vim.fn.search(heading)
    local _end
    if line == 0 then
        line, _ = unpack(vim.api.nvim_win_get_cursor(0))
        _end = line
    else
        _end = vim.fn.search(delimiter)
        if _end == 0 then
            _end = line
        end
    end
    -- Although it would be possible to build table from start it would
    -- be probably much more painful to handle all the optional newline 🤔
    local lines = {}
    for s in result:gmatch("[^\r\n]+") do
        table.insert(lines, s)
    end

    if line > 0 then
        line = line - 1
    end
    vim.api.nvim_buf_set_lines(0, line, _end, false, lines)
end

return M
