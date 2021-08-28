local function setup()
	local nightfox = require("nightfox")
	nightfox.setup({
		fox = "nightfox",
		styles = {
			comments = "italic",
		},
	})
	nightfox.load()
end

local M = {
	setup = setup,
}

return M
