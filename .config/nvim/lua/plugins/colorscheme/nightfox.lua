local function setup()
    local nightfox = require("nightfox")
    nightfox.setup({
        options = { styles = {
            comments = "italic",
        } },
    })
    vim.cmd("colorscheme nightfox")
end

local M = {
    setup = setup,
}

return M
