--   ____       _                  _     _
--  / ___| __ _| | __ ___  ___   _| |   (_)_ __   ___
-- | |  _ / _` | |/ _` \ \/ | | | | |   | | '_ \ / _ \
-- | |_| | (_| | | (_| |>  <| |_| | |___| | | | |  __/
--  \____|\__,_|_|\__,_/_/\_\\__, |_____|_|_| |_|\___|
--                           |___/
-- See: https://github.com/glepnir/galaxyline.nvim
local gl = require("galaxyline")
local vcs = require("galaxyline.providers.vcs")
local condition = require("galaxyline.condition")
local gls = gl.section

local fileinfo = require("galaxyline.providers.fileinfo")

local function u(code)
    if type(code) == "string" then
        code = tonumber("0x" .. code)
    end
    local c = string.char
    if code <= 0x7f then
        return c(code)
    end
    local t = {}
    if code <= 0x07ff then
        t[1] = c(bit.bor(0xc0, bit.rshift(code, 6)))
        t[2] = c(bit.bor(0x80, bit.band(code, 0x3f)))
    elseif code <= 0xffff then
        t[1] = c(bit.bor(0xe0, bit.rshift(code, 12)))
        t[2] = c(bit.bor(0x80, bit.band(bit.rshift(code, 6), 0x3f)))
        t[3] = c(bit.bor(0x80, bit.band(code, 0x3f)))
    else
        t[1] = c(bit.bor(0xf0, bit.rshift(code, 18)))
        t[2] = c(bit.bor(0x80, bit.band(bit.rshift(code, 12), 0x3f)))
        t[3] = c(bit.bor(0x80, bit.band(bit.rshift(code, 6), 0x3f)))
        t[4] = c(bit.bor(0x80, bit.band(code, 0x3f)))
    end
    return table.concat(t)
end

local devicons = require("nvim-web-devicons")

local ayu_dark, ayu_mirage = (function()
    local ayu_colors = {
        bg = { dark = "#0F1419", light = "#FAFAFA", mirage = "#212733" },
        comment = { dark = "#5C6773", light = "#ABB0B6", mirage = "#5C6773" },
        markup = { dark = "#F07178", light = "#F07178", mirage = "#F07178" },
        constant = { dark = "#FFEE99", light = "#A37ACC", mirage = "#D4BFFF" },
        operator = { dark = "#E7C547", light = "#E7C547", mirage = "#80D4FF" },
        tag = { dark = "#36A3D9", light = "#36A3D9", mirage = "#5CCFE6" },
        regexp = { dark = "#95E6CB", light = "#4CBF99", mirage = "#95E6CB" },
        string = { dark = "#B8CC52", light = "#86B300", mirage = "#BBE67E" },
        _function = { dark = "#FFB454", light = "#F29718", mirage = "#FFD57F" },
        special = { dark = "#E6B673", light = "#E6B673", mirage = "#FFC44C" },
        keyword = { dark = "#FF7733", light = "#FF7733", mirage = "#FFAE57" },
        error = { dark = "#FF3333", light = "#FF3333", mirage = "#FF3333" },
        accent = { dark = "#F29718", light = "#FF6A00", mirage = "#FFCC66" },
        panel = { dark = "#14191F", light = "#FFFFFF", mirage = "#272D38" },
        guide = { dark = "#2D3640", light = "#D9D8D7", mirage = "#3D4751" },
        line = { dark = "#151A1E", light = "#F3F3F3", mirage = "#242B38" },
        selection = { dark = "#253340", light = "#F0EEE4", mirage = "#343F4C" },
        fg = { dark = "#E6E1CF", light = "#5C6773", mirage = "#D9D7CE" },
        fg_idle = { dark = "#3E4B59", light = "#828C99", mirage = "#607080" },
    }

    local ayu_mappings = {
        bg = ayu_colors.selection,
        fg = ayu_colors.fg,
        normal = ayu_colors.string,
        insert = ayu_colors.tag,
        replace = ayu_colors.markup,
        visual = ayu_colors.special,
        command = ayu_colors.keyword,
        terminal = ayu_colors.regexp,
        red = ayu_colors.error,
        blue = ayu_colors.tag,
        yellow = ayu_colors.constant,
        inactive = ayu_colors.comment,
    }

    local ayu_dark, ayu_mirage = {}, {}
    for k, v in pairs(ayu_mappings) do
        ayu_dark[k] = v.dark
        ayu_mirage[k] = v.mirage
    end
    return ayu_dark, ayu_mirage
end)()

local colors = ayu_dark

local extra_short_line = {
    "dbui",
    "NvimTree",
    "nerdtree",
    "DiffviewFiles",
    "TelescopePrompt",
}

gl.short_line_list = {
    "LuaTree",
    "vista",
    "startify",
    "term",
    "fugitive",
    "fugitiveblame",
    "plug",
    "git",
    "dbui",
    "NvimTree",
    "nerdtree",
    "DiffviewFiles",
    "TelescopePrompt",
}

-- For some reason this does not work
-- for _, v in ipairs(extra_short_line) do
-- 	table.insert(gl.short_line_list, v)
-- end

local mode_map = {
    ["n"] = { "NORMAL", colors.normal },
    ["i"] = { "INSERT", colors.insert },
    ["R"] = { "REPLACE", colors.replace },
    ["r"] = { "REPLACE", colors.replace },
    ["v"] = { "VISUAL", colors.visual },
    ["V"] = { "V-LINE", colors.visual },
    ["c"] = { "COMMAND", colors.command },
    ["s"] = { "SELECT", colors.visual },
    ["S"] = { "S-LINE", colors.visual },
    ["t"] = { "TERMINAL", colors.terminal },
    [""] = { "V-BLOCK", colors.visual },
    [""] = { "S-BLOCK", colors.visual },
    ["Rv"] = { "VIRTUAL" },
    ["rm"] = { "--MORE" },
}

local sep = {
    right_filled = u("e0b2"),
    left_filled = u("e0b0"),
    right = u("e0b3"),
    left = u("e0b1"),
}

local icons = {
    locker = u("f023"),
    unsaved = u("f693"),
    dos = u("e70f"),
    unix = u("f17c"),
    mac = u("f179"),
    pencil = u("f040"), -- ''
    line_number = u("e0a1"), -- ''
    page = u("2630"), -- '☰', -- 2630
    not_modifiable = u("f05e"), -- '', -- f05e
}

local function mode_label()
    return mode_map[vim.fn.mode()][1] or "N/A"
end
local function mode_hl()
    return mode_map[vim.fn.mode()][2] or colors.none
end

local function buffer_not_empty()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
        return true
    end
    return false
end

local function wide_enough(width)
    local squeeze_width = vim.fn.winwidth(0)
    if squeeze_width > width then
        return true
    end
    return false
end

local function not_extra_short_line()
    local filename = vim.fn.expand("%:t")
    for _, v in pairs(extra_short_line) do
        if filename == v then
            return false
        end
    end
    return true
end

local function not_empty_and_not_extra_file()
    return buffer_not_empty() and not_extra_short_line()
end

local filetype_at_least_width = 95
local diagnostic_at_least_width = 85
local git_status_at_least_width = 110
local file_long_name_at_least_width = 85
local git_branch_at_least_length = 75
local file_name_at_least_length = 55
local lsp_at_least_length = 60

-- NOTE:  using same name as in provider.lua results in some wierd race condition
-- which means that sometimes custome function is executed and sometimes the buildin.
-- Suffix all names with Custom which should prevent name colision. Also names cannot
-- be same in different sections of galaxyline because of how `check_component_exists` in
-- galaxyline.lua works.
-- The separators are there left so that I know there is something but hidden because
-- of width

-- Set default highligh to colors.bg otherwise there will be different color between split
-- windows

vim.cmd("hi Statusline guibg=" .. colors.bg)
vim.cmd("hi StatuslineNC guibg=" .. colors.bg)

gls.left = {
    {
        ViModeCustom = {
            provider = function()
                vim.cmd("highlight GalaxyViMode guifg=" .. colors.bg .. " guibg=" .. mode_hl() .. " gui=bold")
                vim.cmd("highlight GalaxyViModeInv guifg=" .. mode_hl() .. " guibg=" .. colors.bg .. " gui=bold")
                return string.format("  %s ", mode_label())
            end,
            highlight = "GalaxyViMode",
            separator = sep.left_filled,
            separator_highlight = "GalaxyViModeInv",
        },
    },
    {
        FileIconCustom = {
            provider = function()
                if not wide_enough(file_name_at_least_length) then
                    return ""
                end
                local fname, ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
                local icon, iconhl = devicons.get_icon(fname, ext)
                if icon == nil then
                    vim.cmd("highlight GalaxyFileIcon guifg=" .. colors.fg .. " guibg=" .. colors.bg)
                    return ""
                end
                local fg = vim.fn.synIDattr(vim.fn.hlID(iconhl), "fg")
                vim.cmd("highlight GalaxyFileIcon guifg=" .. fg .. " guibg=" .. colors.bg)
                return " " .. icon .. " "
            end,
            highlight = "GalaxyFileIcon",
            condition = buffer_not_empty,
        },
    },
    {
        FileNameCustom = {
            provider = function()
                if not wide_enough(file_name_at_least_length) then
                    return ""
                end
                if not buffer_not_empty() then
                    return ""
                end
                local fname
                local long_fname = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
                if wide_enough(file_long_name_at_least_width + string.len(long_fname)) then
                    fname = long_fname
                else
                    fname = vim.fn.expand("%:t")
                end
                if #fname == 0 then
                    return ""
                end
                if vim.bo.readonly then
                    fname = fname .. " " .. icons.locker
                end
                if not vim.bo.modifiable then
                    fname = fname .. " " .. icons.not_modifiable
                end
                if vim.bo.modified then
                    fname = fname .. " " .. icons.pencil
                end
                return " " .. fname .. " "
            end,
            highlight = { colors.fg, colors.bg },
            separator = sep.left,
            separator_highlight = "GalaxyViModeInv",
        },
    },
    {
        GitIconCustom = {
            provider = function()
                if condition.check_git_workspace() and wide_enough(git_branch_at_least_length) then
                    return "  "
                end
                return ""
            end,
            highlight = { colors.red, colors.bg },
        },
    },
    {
        GitBranchCustom = {
            provider = function()
                if condition.check_git_workspace() and wide_enough(git_branch_at_least_length) then
                    local branch = vcs.get_git_branch()
                    if branch then
                        return branch .. " "
                    end

                    return ""
                end
                return ""
            end,
            highlight = { colors.fg, colors.bg },
            separator = sep.left,
            separator_highlight = "GalaxyViModeInv",
        },
    },
    {
        DiffAddCustom = {
            provider = function()
                if condition.check_git_workspace() and wide_enough(git_status_at_least_width) then
                    return vcs.diff_add()
                end
                return ""
            end,
            icon = " +", -- 
            highlight = { "green", colors.bg },
        },
    },
    {
        DiffModifiedCustom = {
            provider = function()
                if condition.check_git_workspace() and wide_enough(git_status_at_least_width) then
                    return vcs.diff_modified()
                end
                return ""
            end,
            icon = " ~", -- 
            highlight = { "orange", colors.bg },
        },
    },
    {
        DiffRemoveCustom = {
            provider = function()
                if condition.check_git_workspace() and wide_enough(git_status_at_least_width) then
                    return vcs.diff_remove()
                end
                return ""
            end,
            icon = " -", -- 
            highlight = { "red", colors.bg },
            separator = sep.left,
            separator_highlight = "GalaxyViModeInv",
        },
    },
}

gls.right = {
    {
        DiagnosticHintCustom = {
            provider = function()
                if not wide_enough(diagnostic_at_least_width) then
                    return ""
                end
                local n = #vim.diagnostic.get(vim.fn.bufnr("%"), { severity = vim.diagnostic.severity.HINT })
                if n == 0 then
                    return ""
                end
                return string.format(" %s %d ", u("f0eb"), n)
            end,
            highlight = { colors.yellow, colors.bg },
            separator = sep.right,
            separator_highlight = "GalaxyViModeInv",
        },
    },
    {
        DiagnosticInformationCustom = {
            provider = function()
                if not wide_enough(diagnostic_at_least_width) then
                    return ""
                end
                local n = #vim.diagnostic.get(vim.fn.bufnr("%"), { severity = vim.diagnostic.severity.INFO })
                if n == 0 then
                    return ""
                end
                return string.format(" %s %d ", u("f129"), n)
            end,
            highlight = { colors.blue, colors.bg },
        },
    },
    {
        DiagnosticWarnCustom = {
            provider = function()
                if not wide_enough(diagnostic_at_least_width) then
                    return ""
                end
                local n = #vim.diagnostic.get(vim.fn.bufnr("%"), { severity = vim.diagnostic.severity.WARN })
                if n == 0 then
                    return ""
                end
                return string.format(" %s %d ", u("f071"), n)
            end,
            highlight = { "yellow", colors.bg },
        },
    },
    {
        DiagnosticErrorCustom = {
            provider = function()
                if not wide_enough(diagnostic_at_least_width) then
                    return ""
                end
                local n = #vim.diagnostic.get(vim.fn.bufnr("%"), { severity = vim.diagnostic.severity.ERROR })
                if n == 0 then
                    return ""
                end
                return string.format(" %s %d ", u("e009"), n)
            end,
            highlight = { "red", colors.bg },
        },
    },
    {
        LSPStatusCustom = {
            provider = function()
                if not wide_enough(lsp_at_least_length) then
                    return ""
                end
                local clients = vim.lsp.get_active_clients()
                if next(clients) ~= nil then
                    return "   "
                else
                    return ""
                end
            end,
            highlight = { colors.fg, colors.bg },
            separator = sep.right,
            separator_highlight = "GalaxyViModeInv",
        },
    },
    {
        FileTypeCustom = {
            provider = function()
                if not wide_enough(filetype_at_least_width) then
                    return ""
                end
                local icon = icons[vim.bo.fileformat] or ""
                return string.format(" %s %s ", vim.bo.filetype, icon)
            end,
            highlight = { colors.fg, colors.bg },
            separator = sep.right,
            separator_highlight = "GalaxyViModeInv",
        },
    },
    {
        PositionInfoCustom = {
            provider = function()
                return string.format(" %s:%s %s ", vim.fn.line("."), vim.fn.col("."), icons.line_number)
            end,
            highlight = "GalaxyViMode",
            condition = buffer_not_empty,
            separator = sep.right_filled,
            separator_highlight = "GalaxyViModeInv",
        },
    },
    {
        PercentInfoCustom = {
            provider = function()
                return string.format(" %s %s ", fileinfo.current_line_percent(), icons.page)
            end,
            highlight = "GalaxyViMode",
            condition = buffer_not_empty,
            separator = sep.right,
            separator_highlight = "GalaxyViMode",
        },
    },
}

gls.short_line_left = {
    {
        InactiveModeCustomShort = { -- NOTE: having here same highligh name as in ViMode makes some actions really slow like lsp hover.
            provider = function()
                vim.cmd(
                    "highlight GalaxyViModeInactive guifg=" .. colors.bg .. " guibg=" .. colors.inactive .. " gui=bold"
                )
                vim.cmd(
                    "highlight GalaxyViModeInvInactive guifg="
                        .. colors.inactive
                        .. " guibg="
                        .. colors.bg
                        .. " gui=bold"
                )
                if not_extra_short_line() then
                    return string.format("  NORMAL ")
                end
                return ""
            end,
            highlight = "GalaxyViModeInactive",
            separator = sep.left_filled,
            separator_highlight = "GalaxyViModeInvInactive",
        },
    },
    {
        FileIconCustomShort = {
            provider = function()
                local fname, ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
                local icon, iconhl = devicons.get_icon(fname, ext)
                if icon == nil then
                    vim.cmd("highlight GalaxyFileIconInactive guifg=" .. colors.inactive .. " guibg=" .. colors.bg)
                    return ""
                end
                local fg = vim.fn.synIDattr(vim.fn.hlID(iconhl), "fg")
                vim.cmd("highlight GalaxyFileIconInactive guifg=" .. fg .. " guibg=" .. colors.bg)
                return " " .. icon .. " "
            end,
            highlight = "GalaxyFileIconInactive",
            condition = not_empty_and_not_extra_file,
        },
    },
    {
        FileNameCustomShort = {
            provider = function()
                if not buffer_not_empty() then
                    return ""
                end
                local fname = vim.fn.expand("%:t")
                if #fname == 0 then
                    return ""
                end
                if vim.bo.readonly then
                    fname = fname .. " " .. icons.locker
                end
                if not vim.bo.modifiable then
                    fname = fname .. " " .. icons.not_modifiable
                end
                if vim.bo.modified then
                    fname = fname .. " " .. icons.pencil
                end
                return " " .. fname .. " "
            end,
            highlight = { colors.fg, colors.bg },
            condition = not_extra_short_line,
            separator = sep.left,
            separator_highlight = "GalaxyViModeInvInactive",
        },
    },
}

gls.short_line_right = {
    {
        LSPStatusCustomShort = {
            provider = function()
                local clients = vim.lsp.get_active_clients()
                if next(clients) ~= nil then
                    return "   "
                else
                    return ""
                end
            end,
            highlight = { colors.fg, colors.bg },
            condition = not_extra_short_line,
            separator = sep.right,
            separator_highlight = "GalaxyViModeInvInactive",
        },
    },
    {
        FileTypeCustomShort = {
            provider = function()
                local icon = icons[vim.bo.fileformat] or ""
                return string.format(" %s %s ", vim.bo.filetype, icon)
            end,
            highlight = { colors.fg, colors.bg },
            separator = sep.right,
            separator_highlight = "GalaxyViModeInvInactive",
        },
    },
    {
        PositionInfoCustomShort = {
            provider = function()
                if not_extra_short_line() then
                    return string.format(" %s:%s %s ", vim.fn.line("."), vim.fn.col("."), icons.line_number)
                else
                    return string.format(" %s:%s ", vim.fn.line("."), vim.fn.col("."))
                end
            end,
            highlight = "GalaxyViModeInactive",
            condition = buffer_not_empty,
            separator = sep.right_filled,
            separator_highlight = "GalaxyViModeInvInactive",
        },
    },
    {
        PercentInfoCustomShort = {
            provider = function()
                if not_extra_short_line() then
                    return string.format(" %s %s ", fileinfo.current_line_percent(), icons.page)
                else
                    return string.format(" %s ", fileinfo.current_line_percent())
                end
            end,
            highlight = "GalaxyViModeInactive",
            condition = buffer_not_empty,
            separator = sep.right,
            separator_highlight = "GalaxyViModeInactive",
        },
    },
}
