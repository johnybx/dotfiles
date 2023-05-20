return {
    -- Themes
    { "navarasu/onedark.nvim", cond = false },
    { "EdenEast/nightfox.nvim", cond = false },
    { "catppuccin/nvim", cond = false },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            ---@diagnostic disable: unused-local
            local utils = require("utils")
            utils.opt("o", "termguicolors", true)

            local onedark = require("plugins.colorscheme.onedark")
            local gruvbox = require("plugins.colorscheme.gruvbox")
            local nightfox = require("plugins.colorscheme.nightfox")
            local catppuccino = require("plugins.colorscheme.catppuccino")

            -- nightfox.setup()
            -- catppuccino.setup()
            gruvbox.setup()
            -- onedark.setup()

            -- Nice undercurl
            vim.api.nvim_exec(
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
                false
            )
        end,
    },
    { "marko-cerovac/material.nvim", cond = false },
    -- { "arcticicestudio/nord-vim" },
    -- { "folke/tokyonight.nvim" },
    -- { "patstockwell/vim-monokai-tasty" },
}
