-- Load custom tree-sitter grammar for org filetype
require("orgmode").setup_ts_grammar()
require("orgmode").setup({
    org_agenda_files = { "~/workspace/orgmode/**" },
    org_default_notes_file = "~/workspace/orgmode/default.org",
    org_capture_templates = {
        t = "Task",
        tt = { description = "Task TODO", template = "* TODO %?\n %u" },
        tf = { description = "Task TODO with file and line", template = "* TODO %?\n %u\n %a" },
        td = {
            description = "Task TODO with file, line and description",
            template = "* TODO %^{PROMPT}\n %u\n %a\n %?",
        },

        n = { description = "NOTE", template = "* %^{PROMPT}\n %u\n %?\n" },
    },
})
