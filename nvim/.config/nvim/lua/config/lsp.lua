vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local buffer = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		-- Helper function for keymaps
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
		end

		-- ══════════════════════════════════════════
		-- LSP Info
		-- ══════════════════════════════════════════
		map("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")

		-- ══════════════════════════════════════════
		-- Navigation
		-- ══════════════════════════════════════════
		map("n", "gd", function()
			require("telescope.builtin").lsp_definitions({ reuse_win = true })
		end, "Goto Definition")

		map("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end, "References")

		map("n", "gI", function()
			require("telescope.builtin").lsp_implementations({ reuse_win = true })
		end, "Goto Implementation")

		map("n", "gy", function()
			require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
		end, "Goto T[y]pe Definition")

		map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")

		-- ══════════════════════════════════════════
		-- Hover & Signature
		-- ══════════════════════════════════════════
		map("n", "K", vim.lsp.buf.hover, "Hover")
		map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
		map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help")

		-- ══════════════════════════════════════════
		-- Code Actions
		-- ══════════════════════════════════════════
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

		map({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens")

		map("n", "<leader>cC", function()
			vim.lsp.codelens.refresh()
			vim.lsp.codelens.display()
		end, "Refresh & Display Codelens")

		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")

		map("n", "<leader>cA", function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source" },
					diagnostics = {},
				},
			})
		end, "Source Action")

		-- ══════════════════════════════════════════
		-- Rename File (for supported servers)
		-- ══════════════════════════════════════════
		map("n", "<leader>cR", function()
			local old_name = vim.api.nvim_buf_get_name(0)
			local new_name = vim.fn.input("New name: ", old_name, "file")
			if new_name ~= "" and new_name ~= old_name then
				vim.lsp.util.rename(old_name, new_name)
			end
		end, "Rename File")

		-- ══════════════════════════════════════════
		-- Reference Navigation
		-- ══════════════════════════════════════════
		if client and client.server_capabilities.documentHighlightProvider then
			-- Highlight references on cursor hold
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = buffer,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = buffer,
				callback = vim.lsp.buf.clear_references,
			})
		end

		-- Next/Prev reference navigation using Illuminate
		map("n", "]]", function()
			require("illuminate").goto_next_reference(false)
		end, "Next Reference")

		map("n", "[[", function()
			require("illuminate").goto_prev_reference(false)
		end, "Prev Reference")

		map("n", "<a-n>", function()
			require("illuminate").goto_next_reference(false)
		end, "Next Reference")

		map("n", "<a-p>", function()
			require("illuminate").goto_prev_reference(false)
		end, "Prev Reference")

		-- ══════════════════════════════════════════
		-- Symbols
		-- ══════════════════════════════════════════
		map("n", "<leader>ss", function()
			require("telescope.builtin").lsp_document_symbols()
		end, "LSP Symbols")

		map("n", "<leader>sS", function()
			require("telescope.builtin").lsp_dynamic_workspace_symbols()
		end, "LSP Workspace Symbols")

		-- ══════════════════════════════════════════
		-- Call Hierarchy
		-- ══════════════════════════════════════════
		map("n", "gai", function()
			vim.lsp.buf.incoming_calls()
		end, "C[a]lls Incoming")

		map("n", "gao", function()
			vim.lsp.buf.outgoing_calls()
		end, "C[a]lls Outgoing")
	end,
})
