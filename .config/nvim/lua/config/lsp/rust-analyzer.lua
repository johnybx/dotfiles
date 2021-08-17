local function setup(on_attach, capabilities)
	require("lspconfig")["rust_analyzer"].setup({
		cmd = { "rustup", "run", "nightly", "rust-analyzer" },
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

M = {
	setup = setup,
}

return M
