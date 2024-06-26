return {
    "harrisoncramer/gitlab.nvim",
    -- dir = "~/workspace/nvim/gitlab.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "stevearc/dressing.nvim",
    },
    branch = "main",
    -- Lazy load is not very supported yet
    -- keys = {
    --     { "<leader>glr", nil, mode = "n", desc = "Gitlab review" },
    --     { "<leader>gls", nil, mode = "n", desc = "Gitlab summary" },
    --     { "<leader>glA", nil, mode = "n", desc = "Gitlab approve MR" },
    --     { "<leader>glR", nil, mode = "n", desc = "Gitlab revoke approve MR" },
    --     { "<leader>glc", nil, mode = "n", desc = "Gitlab create comment" },
    --     { "<leader>gln", nil, mode = "n", desc = "Gitlab create note" },
    --     {
    --         "<leader>gld",
    --         nil,
    --         mode = "n",
    --         desc = "Gitlab toggle discussion",
    --     },
    --     { "<leader>glaa", nil, mode = "n", desc = "Gitlab add assignee" },
    --     {
    --         "<leader>glad",
    --         nil,
    --         mode = "n",
    --         desc = "Gitlab delete assignee",
    --     },
    --     { "<leader>glra", nil, mode = "n", desc = "Gitlab add reviewer" },
    --     {
    --         "<leader>glrd",
    --         nil,
    --         mode = "n",
    --         desc = "Gitlab remove reviewer",
    --     },
    --     { "<leader>glp", nil, mode = "n", desc = "Gitlab Pipeline" },
    --     { "<leader>glo", nil, mode = "n", desc = "Gitlab open in browser" },
    -- },
    cond = function()
        if os.getenv("GITLAB_TOKEN") then
            return true
        else
            return false
        end
    end,
    event = "VeryLazy",
    build = function()
        require("gitlab.server").build(true)
    end,
    config = function()
        require("gitlab").setup({
            reviewer = "diffview",
            port = nil,
            open_reviewer_against = "filesystem",
            discussion_tree = {
                auto_open = false,
                toggle_node = "<Tab>",
                position = "bottom",
                tree_type = "per_filename",
            },
            reviewer_settings = {
                diffview = {
                    imply_local = true,
                },
            },
            discussion_sign_and_diagnostic = {
                skip_resolved_discussion = false,
                skip_old_revision_discussion = true,
            },
        })
        local utils = require("utils")
        utils.map("n", "<leader>glr", '<cmd>lua require("gitlab").review()<CR>')
        utils.map("n", "<leader>glS", '<cmd>lua require("gitlab").summary()<CR>')
        utils.map("n", "<leader>glA", '<cmd>lua require("gitlab").approve()<CR>')
        utils.map("n", "<leader>glR", '<cmd>lua require("gitlab").revoke()<CR>')
        utils.map("n", "<leader>glc", '<cmd>lua require("gitlab").create_comment()<CR>')
        utils.map("v", "<leader>glc", '<cmd>lua require("gitlab").create_multiline_comment()<CR>')
        utils.map("v", "<leader>gls", '<cmd>lua require("gitlab").create_comment_suggestion()<CR>')
        utils.map("n", "<leader>glm", '<cmd>lua require("gitlab").move_to_discussion_tree_from_diagnostic()<CR>')
        utils.map("n", "<leader>gln", '<cmd>lua require("gitlab").create_note()<CR>')
        utils.map("n", "<leader>gld", '<cmd>lua require("gitlab").toggle_discussions()<CR>')
        utils.map("n", "<leader>glaa", '<cmd>lua require("gitlab").add_assignee()<CR>')
        utils.map("n", "<leader>glad", '<cmd>lua require("gitlab").delete_assignee()<CR>')
        utils.map("n", "<leader>glra", '<cmd>lua require("gitlab").add_reviewer()<CR>')
        utils.map("n", "<leader>glrd", '<cmd>lua require("gitlab").delete_reviewer()<CR>')
        utils.map("n", "<leader>glp", '<cmd>lua require("gitlab").pipeline()<CR>')
        utils.map("n", "<leader>glo", '<cmd>lua require("gitlab").open_in_browser()<CR>')
        utils.map("n", "<leader>glla", '<cmd>lua require("gitlab").add_label()<CR>')
        utils.map("n", "<leader>glld", '<cmd>lua require("gitlab").delete_label()<CR>')
        utils.map("n", "<leader>gl<Space>", ':lua require("gitlab").')
        utils.map("n", "<leader>glB", function()
            require("gitlab.server").restart(function()
                vim.cmd.tabclose()
                require("gitlab").review()
            end)
        end)
    end,
}
