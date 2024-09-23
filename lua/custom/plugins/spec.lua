return {
	{ "nvim-lua/plenary.nvim" },

	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	-- git handling
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR><C-w>L")

			local Alex_Fugutive = vim.api.nvim_create_augroup("Alex_Fugutive", {})

			local autocmd = vim.api.nvim_create_autocmd
			autocmd("BufWinEnter", {
				group = Alex_Fugutive,
				pattern = "*",
				callback = function()
					if vim.bo.ft ~= "fugitive" then
						return
					end

					local bufnr = vim.api.nvim_get_current_buf()
					local opts = {
						buffer = bufnr,
						remap = false,
					}
					vim.keymap.set("n", "<leader>P", function()
						vim.cmd.Git("push")
					end, opts)

					vim.keymap.set("n", "<leader>PF", function()
						vim.cmd.Git("push --force-with-lease")
					end, opts)

					-- NOTE: It allows me to easily set the branch i am pushing and any tracking
					-- needed if i did not set the branch up correctly
					vim.keymap.set("n", "<leader>po", ":Git push -u origin ", opts)

					-- reset to the previous commit
					vim.keymap.set("n", "<leader>rs", "<cmd>Git reset HEAD~1<CR>", opts)

					-- setup branch
					vim.keymap.set("n", "<leader>ps", ":Git push --set-upstream origin ", opts)
				end,
			})
		end,
	},
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
	},

	{ "davidhalter/jedi-vim" },

	{ "junegunn/fzf.vim" },
	{ "junegunn/fzf", build = "./install --all" },

	--  { 'jose-elias-alvarez/null-ls.nvim' } -- press F... archived
	-- codeium
	{
		"Exafunction/codeium.vim",
		config = function()
			-- disable default tab
			vim.g.codeium_no_map_tab = 1
			-- set new shortcut for codeium
			vim.keymap.set("i", "<M-y>", function()
				return vim.fn["codeium#Accept"]()
			end, {
				expr = true,
				silent = true,
			})
			vim.keymap.set("i", "<M-Backspace>", function()
				return vim.fn["codeium#Clear"]()
			end, {
				expr = true,
				silent = true,
			})
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			signs = false,
		},
	},

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		config = function()
			vim.keymap.set("n", "<leader>xx", function()
				require("trouble").toggle()
			end)
			vim.keymap.set("n", "<leader>xw", function()
				require("trouble").toggle("workspace_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xd", function()
				require("trouble").toggle("document_diagnostics")
			end)

			vim.keymap.set("n", "<leader>qf", function()
				require("trouble").toggle("quickfix")
			end)

			vim.keymap.set("n", "<leader>xl", function()
				require("trouble").toggle("loclist")
			end)

			vim.keymap.set("n", "gR", function()
				require("trouble").toggle("lsp_references")
			end)
		end,
	},
	-- markdown realtime preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			vim.keymap.set("n", "<leader>md", "<cmd>MarkdownPreview<cr>")
		end,
	},

	-- file tree
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			-- disable netrw at the very start of your init.lua
			-- vim.g.loaded_netrw = 1
			-- vim.g.loaded_netrwPlugin = 1

			-- set termguicolors to enable highlight groups
			vim.opt.termguicolors = true

			-- empty setup using defaults
			-- require("nvim-tree").setup()

			-- global
			-- local api = require("nvim-tree.api")

			-- vim.keymap.set("n", "h", api.tree.close)
			-- vim.keymap.set("n", "H", api.tree.collapse_all)

			local HEIGHT_RATIO = 0.8 -- You can change this
			local WIDTH_RATIO = 0.5 -- You can change this too

			local tree_api = require("nvim-tree")
			local tree_view = require("nvim-tree.view")

			vim.api.nvim_create_augroup("NvimTreeResize", {
				clear = true,
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				command = "NvimTreeToggle",
			})

			vim.api.nvim_create_autocmd({ "VimResized" }, {
				group = "NvimTreeResize",
				callback = function()
					if tree_view.is_visible() then
						tree_view.close()
						tree_api.open()
					end
				end,
			})

			tree_api.setup({
				-- added for updating tree if file changes
				auto_reload_on_write = true,
				hijack_cursor = true,
				-- hijack_unnamed_buffer_when_opening=true,

				update_focused_file = {
					enable = true,
					update_root = false,
					ignore_list = {},
				},
				renderer = {
					add_trailing = false,
					group_empty = true,
					full_name = false,
					root_folder_label = ":~:s?$?/..?",
					indent_width = 2,
					special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
					symlink_destination = true,
					highlight_git = false,
					highlight_diagnostics = "all",
					highlight_opened_files = "none",
					highlight_modified = "none",
					highlight_bookmarks = "none",
					highlight_clipboard = "name",
					indent_markers = {
						enable = true,
						inline_arrows = true,
						icons = {
							corner = "└",
							edge = "│",
							item = "│",
							bottom = "─",
							none = " ",
						},
					},
					icons = {
						web_devicons = {
							file = {
								enable = true,
								color = true,
							},
							folder = {
								enable = true,
								color = true,
							},
						},
						git_placement = "before",
						modified_placement = "after",
						diagnostics_placement = "signcolumn",
						bookmarks_placement = "signcolumn",
						padding = " ",
						symlink_arrow = " ➛ ",
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
							modified = true,
							diagnostics = true,
							bookmarks = false,
						},
						glyphs = {
							default = "",
							symlink = "",
							bookmark = "",
							modified = "*",
							folder = {
								arrow_closed = "",
								arrow_open = "",
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
								symlink_open = "",
							},
							git = {
								unstaged = "✗",
								staged = "✓",
								unmerged = "",
								renamed = "➜",
								untracked = "★",
								deleted = "",
								ignored = "◌",
							},
						},
					},
				},
				git = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
					severity = {
						min = vim.diagnostic.severity.ERROR,
						max = vim.diagnostic.severity.ERROR,
					},
				},
				modified = {
					enable = true,
				},
				view = {
					cursorline = true,
					relativenumber = true,
					signcolumn = "yes",
					float = {
						enable = true,
						open_win_config = function()
							local screen_w = vim.opt.columns:get()
							local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
							local window_w = screen_w * WIDTH_RATIO
							local window_h = screen_h * HEIGHT_RATIO
							local window_w_int = math.floor(window_w)
							local window_h_int = math.floor(window_h)
							local center_x = (screen_w - window_w) / 2
							local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
							return {
								border = "rounded",
								relative = "editor",
								row = center_y,
								col = center_x,
								width = window_w_int,
								height = window_h_int,
							}
						end,
					},
					width = function()
						return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
					end,
				},
			})

			-- local function change_root_to_global_cwd()
			--   local api = require("nvim-tree.api")
			--   local global_cwd = vim.fn.getcwd(-1, -1)
			--   api.tree.change_root(global_cwd)
			-- end
		end,
	},
	{ "nvim-tree/nvim-web-devicons" },
	-- vim be good
	{ "ThePrimeagen/vim-be-good" },

	-- nvim surround
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- debugger nvim-dap
	{
		"mfussenegger/nvim-dap",
		config = function()
			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end)
			vim.keymap.set("n", "<Leader>b", function()
				require("dap").toggle_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>B", function()
				require("dap").set_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>lp", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end)
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").run_last()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				require("dap.ui.widgets").preview()
			end)
			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end)
			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end)
		end,
	},
	{ "mfussenegger/nvim-dap-python" },

	-- DB
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-completion" },
	{ "kristijanhusak/vim-dadbod-ui" },
	-- themes
	-- { "catppuccin/nvim", as = "catppuccin" }
	-- { "ellisonleao/gruvbox.nvim" }
	-- { "bluz71/vim-moonfly-colors" }
	-- { "sho-87/kanagawa-paper.nvim" }

	-- comments
	-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
	{
		"numToStr/Comment.nvim",
		config = function()
			-- gc - single line
			-- gb - block line
			-- gcc - comment cur line
			-- gbb - block comment curr
			-- gco - o with comment
			-- gcO - O with comment
			-- gcA - A with comment
			-- disable comments on new line
			vim.cmd("autocmd BufEnter * set formatoptions-=cro")
			vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

			require("Comment").setup({
				padding = true,
				sticky = true,
				ignore = nil,
				toggler = {
					line = "gcc",
					block = "gbc",
				},
				opleader = {
					line = "gc",
					block = "gb",
				},
				extra = {
					above = "gcO",
					below = "gco",
					eol = "gcA",
				},
				mappings = {
					basic = true,
					extra = true,
				},
				pre_hook = nil,
				post_hook = nil,
			})
		end,
	},
}
