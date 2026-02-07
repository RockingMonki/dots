require("core.options")
require("core.mappings")
require("core.lazy")
require("core.autocmd")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
