local function setup()
    require("gruvbox").setup({
        bold = false,
        contrast = "hard",
        transparent_mode = true,
    })
    vim.cmd("colorscheme gruvbox")

    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#283a28" })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#243244" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#562828" })
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#626240" })
end

local M = {
    setup = setup,
}

return M
