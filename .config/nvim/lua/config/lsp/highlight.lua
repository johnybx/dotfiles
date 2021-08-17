local function highlight(client)
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
            hi LspReferenceRead gui=none guibg=#393f4a
            hi LspReferenceText gui=none guibg=#393f4a
            hi LspReferenceWrite gui=none guibg=#393f4a
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]],
			false
		)
		require("illuminate").on_attach(client)
	end
end

M = {
	highlight = highlight,
}
return M
