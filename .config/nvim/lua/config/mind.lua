local function initialize_project_structure()
    require("mind").wrap_smart_project_tree_fn(function(args)
        local tree = args.get_tree()
        local mind_node = require("mind.node")

        local _, tasks = mind_node.get_node_by_path(tree, "/Tasks", true)
        tasks.icon = "陼"

        local _, backlog = mind_node.get_node_by_path(tree, "/Tasks/Backlog", true)
        backlog.icon = " "

        local _, on_going = mind_node.get_node_by_path(tree, "/Tasks/On-going", true)
        on_going.icon = " "

        local _, done = mind_node.get_node_by_path(tree, "/Tasks/Done", true)
        done.icon = " "

        local _, cancelled = mind_node.get_node_by_path(tree, "/Tasks/Cancelled", true)
        cancelled.icon = " "

        local _, notes = mind_node.get_node_by_path(tree, "/Notes", true)
        notes.icon = " "

        args.save_tree()
        require("mind.ui").rerender(tree, args.opts)
    end)
end

require("mind").setup({
    keymaps = {
        normal = {
            C = initialize_project_structure,
        },
    },
})
