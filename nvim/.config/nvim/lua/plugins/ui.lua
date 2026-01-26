return {
	-- icons (shared dependency)
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},

	-- lualine (statusline)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					icons_enabled = true,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					-- disable lualine for file-explorer windows so statusline doesn't conflict
					disabled_filetypes = {
						statusline = { "dashboard", "alpha", "neo-tree", "neo-tree-popup" },
					},
				},

				sections = {
					lualine_a = { { "mode", icon = "" } },
					lualine_b = { { "branch", icon = "" }, "diff" },
					lualine_c = {
						{
							"filename",
							file_status = true,
							path = 1,
							symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
						},
					},
					lualine_x = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
						"filetype",
						"encoding",
						"fileformat",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},

				inactive_sections = {
					lualine_c = { "filename" },
					lualine_x = { "location" },
				},
			})
		end,
	},

	-- bufferline (tabline)
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					numbers = "none",
					close_command = "bdelete! %d",
					right_mouse_command = "bdelete! %d",
					indicator = { style = "icon", icon = "▎" },
					buffer_close_icon = "󰅖",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",

					-- reserve space for file explorers so bufferline and tabs don't overlap
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true,
						},
						{
							-- neo-tree uses filetype "neo-tree" (and "neo-tree-popup" for some windows)
							filetype = "neo-tree",
							text = "Explorer",
							highlight = "Directory",
							separator = true,
						},
					},

					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,

					show_buffer_icons = true,
					show_buffer_close_icons = true,
					show_close_icon = false,
					show_tab_indicators = true,
					separator_style = "slant",
					always_show_bufferline = true,
				},
			})

			-- handy buffer navigation
			vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
			vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
			vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { silent = true })
		end,
	},

	-- neo-tree (file explorer) — left sidebar, non-conflicting
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional but recommended
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = false,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				default_component_configs = {
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "ﰊ",
					},
				},

				window = {
					position = "left",
					width = 35,
					mapping_options = { noremap = true, nowait = true },
				},

				filesystem = {
					follow_current_file = { enabled = true }, -- highlight current file
					use_libuv_file_watcher = true, -- auto-refresh
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = true,
						never_show = { ".DS_Store" },
					},
				},

				buffers = {
					follow_current_file = true,
				},

				-- Do not allow other buffers to take over the neo-tree window
				-- (neo-tree is designed to be polite and keep its side-panel intact)
			})

			-- toggle keymap (adjust to your leader if it's different)
			vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<CR>", { noremap = true, silent = true })
			-- optional: key to reveal the current file in the tree
			vim.keymap.set("n", "<leader>e", "<cmd>Neotree reveal<CR>", { noremap = true, silent = true })
		end,
	},
}
