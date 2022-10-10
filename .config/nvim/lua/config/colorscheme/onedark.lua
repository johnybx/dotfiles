local function setup()
    local onedark = require("onedark")
    onedark.setup({
        style = "darker",
        colors = {
            red = "#e06c75",
        },
        highlights = {
            rainbowcol1 = { fg = "$red" },
            rainbowcol2 = { fg = "$orange" },
            rainbowcol3 = { fg = "$blue" },
            rainbowcol4 = { fg = "$purple" },
            rainbowcol5 = { fg = "$green" },
            rainbowcol6 = { fg = "$yellow" },
            rainbowcol7 = { fg = "$grey" },
            TSPunctDelimiter = { fg = "$red" },
            TSPunctField = { fg = "$red" },
            TSVariableBuiltin = { fg = "$red" },
        },
    })
    onedark.load()
end

local M = {
    setup = setup,
}

return M
