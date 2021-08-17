local function setup(on_attach, capabilities)
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	local luadev = require("lua-dev").setup({
		-- add any options here, or leave empty to use the default settings
		lspconfig = {
			cmd = { "lua-language-server" },
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
						-- Setup your lua path
						path = runtime_path,
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = { enable = false },
					color = { mode = "Semantic" },
				},
			},
		},
	})

	local lspconfig = require("lspconfig")
	lspconfig.sumneko_lua.setup(luadev)
end

M = {
	setup = setup,
}
return M
