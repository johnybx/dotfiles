-- --------------------- Startify ---------------------

vim.g.startify_session_dir = "~/.config/nvim/sessions"

vim.g.startify_lists = {
    { type = "dir", header = { "   Current Directory: " .. vim.fn.getcwd() } },
    { type = "files", header = { "   Files" } },
    { type = "sessions", header = { "   Sessions" } },
    { type = "bookmarks", header = { "   Bookmarks" } },
}

vim.g.startify_session_autoload = 0
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1

vim.g.startify_bookmarks = {
    { i3 = "~/.config/i3/config" },
    { cf = "~/.config/nvim/init.lua" },
    { bs = "~/.bashrc" },
    { zs = "~/.config/zsh/.zshrc" },
}

vim.g.startify_enable_special = 1
