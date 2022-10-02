local function setup()
    local onedark = require("onedark")
    onedark.setup({ style = "darker" })
    onedark.load()
end

local M = {
    setup = setup,
}

return M
