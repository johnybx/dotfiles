local function theme_defaults()
    local utils = require("utils")
    utils.opt("o", "termguicolors", true)
    -- Nice undercurl
    vim.api.nvim_exec2(
        [[
            hi DiagnosticUnderlineWarn gui=undercurl guisp=#e0af68
            hi DiagnosticUnderlineError gui=undercurl guisp=#db4b4b
            hi DiagnosticUnderlineHint gui=undercurl guisp=#1abc9c
            hi DiagnosticUnderlineInfo gui=undercurl guisp=#0db9d7
            hi SpellBad gui=undercurl
            hi SpellCap gui=undercurl
            hi SpellLocal gui=undercurl
            hi SpellRare gui=undercurl
            ]],
        { output = false }
    )
end

---@diagnostic disable-next-line: unused-function, unused-local
local function transparent_background()
    vim.api.nvim_exec2(
        [[
    highlight Normal guibg=none ctermbg=none
    highlight NonText guibg=none ctermbg=none
    ]],
        { output = false }
    )
end

return {
    -- Themes
    { "navarasu/onedark.nvim", cond = false },
    { "EdenEast/nightfox.nvim", cond = false },
    { "catppuccin/nvim", cond = false },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        cond = function()
            if os.getenv("TMUX_IN_GUAKE") then
                return true
            end
            return false
        end,
        config = function()
            ---@diagnostic disable: unused-local

            local onedark = require("plugins.colorscheme.onedark")
            local gruvbox = require("plugins.colorscheme.gruvbox")
            local nightfox = require("plugins.colorscheme.nightfox")
            local catppuccino = require("plugins.colorscheme.catppuccino")

            gruvbox.setup()
            theme_defaults()
        end,
    },
    { "marko-cerovac/material.nvim", cond = false },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy = false,
        cond = function()
            if os.getenv("TMUX_IN_GUAKE") then
                return false
            end
            return true
        end,
        config = function()
            require("kanagawa").setup({
                statementStyle = { bold = false },
                transparent = true,

                overrides = function()
                    return {
                        ["@lsp.typemod.function.readonly"] = { bold = false },
                    }
                end,
            })
            vim.cmd("colorscheme kanagawa")
        end,
    },
    -- { "arcticicestudio/nord-vim" },
    -- { "folke/tokyonight.nvim" },
    -- { "patstockwell/vim-monokai-tasty" },
}
