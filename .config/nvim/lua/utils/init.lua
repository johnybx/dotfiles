local utils = {}

local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

function utils.map(mode, lhs, rhs, opts)
    local options = {}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

function utils.replace_substring(substring)
    local _, s_row, _, _ = unpack(vim.fn.getpos("'<"))
    local _, e_row, _, _ = unpack(vim.fn.getpos("'>"))
    local text = vim.api.nvim_buf_get_lines(0, s_row - 1, e_row, false)
    for k, v in pairs(text) do
        text[k] = string.gsub(v, substring, "")
    end
    vim.api.nvim_buf_set_lines(0, s_row - 1, e_row, false, text)
end

return utils
