-- --------------------- Startify ---------------------

vim.g.startify_session_dir = "~/.config/nvim/sessions"

vim.g.startify_lists = {
    { type = "dir", header = { "   Current Directory: " .. vim.fn.getcwd() } },
    { type = "files", header = { "   Files" } },
    { type = "sessions", header = { "   Sessions" } },
    { type = "commands", header = { "   Commands" } },
    { type = "bookmarks", header = { "   Bookmarks" } },
}

vim.g.startify_session_autoload = 0
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1

vim.g.startify_commands = {
    { fg = "Telescope git_files" },
    { ff = "Telescope find_files" },
    { fe = "Telescope file_browser" },
    { o = "Oil" },
}
vim.g.startify_bookmarks = {
    { i3 = "~/.config/i3/config" },
    { cf = "~/.config/nvim/init.lua" },
    { bs = "~/.bashrc" },
    { zs = "~/.config/zsh/.zshrc" },
}

vim.g.startify_enable_special = 1

return {
    "mhinz/vim-startify",
    event = "VimEnter",
    config = function()
        -- https://github.com/mhinz/vim-startify/issues/549
        vim.api.nvim_create_autocmd("VimEnter", {
            group = vim.api.nvim_create_augroup("Dashboard", { clear = true }),
            callback = function()
                if
                    vim.fn.argc() == 0
                    and vim.api.nvim_buf_line_count(0) == 1
                    and vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == ""
                then
                    vim.cmd("Startify")
                end
            end,
        })
    end,
}
