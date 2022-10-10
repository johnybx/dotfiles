local function check_lsp()
    local clients = vim.lsp.get_active_clients()
    if next(clients) ~= nil then
        return ""
    else
        return ""
    end
end

require("lualine").setup({
    sections = {
        lualine_x = { check_lsp, "fileformat", "filetype" },
        lualine_c = {
            { "filename", path = 1, shorting_target = 60 },
        },
    },
    inactive_sections = {
        lualine_c = {
            { "filename", path = 1 },
        },
    },
})
