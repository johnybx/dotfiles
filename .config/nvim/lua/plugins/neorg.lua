return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
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
        },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
}
