return {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    opts = {
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.export"] = {}, -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.presenter"] = {
                config = {
                    zen_mode = "zen-mode",
                },
            },
            ["core.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        notes = "~/workspace/neorg/notes",
                        work = "~/workspace/neorg/work",
                    },
                },
            },
            ["core.summary"] = {},
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.keybinds"] = {
                config = {
                    hook = function(keybinds)
                        keybinds.map(
                            "norg",
                            "n",
                            keybinds.leader .. "nt",
                            "<cmd>lua require('plugins.neorg.utils').generate_dir_contents()<CR>"
                        )
                    end,
                },
            },
            ["core.itero"] = {},
            ["core.promo"] = {},
            ["core.qol.toc"] = {},
        },
    },
    dependencies = { "luarocks.nvim" },
}
