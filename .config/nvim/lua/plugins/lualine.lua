local function check_lsp()
    local clients = vim.lsp.get_clients()
    if next(clients) ~= nil then
        return ""
    else
        return ""
    end
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = {
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
    },
}
