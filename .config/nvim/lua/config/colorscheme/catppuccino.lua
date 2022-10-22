local function setup()
    local catppuccin = require("catppuccin")
    vim.g.catppuccin_flavour = "macchiato"
    catppuccin.setup()
    catppuccin.load()
end

local M = {
    setup = setup,
}

return M
