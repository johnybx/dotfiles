return {
    "alvarosevilla95/luatab.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local cell = require("luatab").helpers.cell
        local extract_highlight_colors = require("luatab.highlight").extract_highlight_colors

        local function tabline()
            local i = 1
            local line = ""
            local selected = vim.fn.tabpagenr()
            while i <= vim.fn.tabpagenr("$") do
                local hl = (selected == i and "%#TabNumSel#" or "%#TabNum#")
                line = line .. hl .. " " .. i .. ":" .. cell(i)
                i = i + 1
            end
            return line .. "%T%#TabLineFill#%="
        end

        local bg = extract_highlight_colors("TabLine", "bg")
        if bg == nil then
            bg = "none"
        end
        local bg_sel = extract_highlight_colors("TabLineSel", "bg")
        if bg_sel == nil then
            bg_sel = "none"
        end
        local fg = "#dd7f47"
        vim.cmd("hi TabNum term=bold guifg=" .. fg .. " guibg=" .. bg)
        vim.cmd("hi TabNumSel term=bold guifg=" .. fg .. " guibg=" .. bg_sel)

        -- vim.o.tabline = "%!v:lua.require'config.luatab'.tabline()"
        require("luatab").setup({
            tabline = tabline,
        })
    end,
}
