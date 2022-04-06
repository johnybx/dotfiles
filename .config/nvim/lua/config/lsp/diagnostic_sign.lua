local function setup()
    vim.fn.sign_define("DiagnosticSignError", { text = " 🞮", numhl = "DiagnosticError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", numhl = "DiagnosticWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ⁈", numhl = "DiagnosticInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = " 🛈", numhl = "DiagnosticHint" })
end

M = {
    setup = setup,
}

return M
