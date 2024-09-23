return {
	-- smooth scrolling
	{
		"karb94/neoscroll.nvim",
	},
	-- try out scrollbar
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup({
				show = true,
				show_in_active_only = true,
				set_highlights = true,
				folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
				max_lines = false, -- disables if no. of lines in buffer exceeds this
				hide_if_all_visible = false, -- Hides everything if all lines are visible
				throttle_ms = 100,
				handle = {
					text = " ",
					blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
					color = nil,
					color_nr = nil, -- cterm
					highlight = "CursorColumn",
					hide_if_all_visible = true, -- Hides handle if all lines are visible
				},
				marks = {
					Cursor = {
						text = "",
						priority = 0,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "Normal",
					},
					Search = {
						text = { "-", "=" },
						priority = 1,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "Search",
					},
					Error = {
						text = { "-", "=" },
						priority = 2,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "DiagnosticVirtualTextError",
					},
					Warn = {
						text = { "-", "=" },
						priority = 3,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "DiagnosticVirtualTextWarn",
					},
					Info = {
						text = { "-", "=" },
						priority = 4,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "DiagnosticVirtualTextInfo",
					},
					Hint = {
						text = { "-", "=" },
						priority = 5,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "DiagnosticVirtualTextHint",
					},
					Misc = {
						text = { "-", "=" },
						priority = 6,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "Normal",
					},
					GitAdd = {
						text = "┆",
						priority = 7,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "GitSignsAdd",
					},
					GitChange = {
						text = "┆",
						priority = 7,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "GitSignsChange",
					},
					GitDelete = {
						text = "▁",
						priority = 7,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "GitSignsDelete",
					},
				},
				excluded_buftypes = { "terminal" },
				excluded_filetypes = { "cmp_docs", "cmp_menu", "noice", "prompt", "TelescopePrompt" },
				autocmd = {
					render = {
						"BufWinEnter",
						"TabEnter",
						"TermEnter",
						"WinEnter",
						"CmdwinLeave",
						"TextChanged",
						"VimResized",
						"WinScrolled",
					},
					clear = { "BufWinLeave", "TabLeave", "TermLeave", "WinLeave" },
				},
				handlers = {
					cursor = false,
					diagnostic = true,
					gitsigns = true, -- Requires gitsigns
					handle = true,
					search = false, -- Requires hlslens
					ale = false, -- Requires ALE
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = {
						text = "┃",
					},
					change = {
						text = "┃",
					},
					delete = {
						text = "_",
					},
					topdelete = {
						text = "‾",
					},
					changedelete = {
						text = "┃",
					},
					untracked = {
						text = "┃",
					},
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				auto_attach = true,
				attach_to_untracked = true,
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 0,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d %H:%M> - <summary>",
				-- current_line_blame_formatter_opts = {
				--   relative_time = false,
				-- },
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				-- git signs keymaps
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({
								"]c",
								bang = true,
							})
						else
							gitsigns.nav_hunk("next")
						end
					end)

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({
								"[c",
								bang = true,
							})
						else
							gitsigns.nav_hunk("prev")
						end
					end)

					-- Actions
					map("n", "<leader>hs", gitsigns.stage_hunk)
					map("n", "<leader>hr", gitsigns.reset_hunk)
					map("n", "<leader>hu", gitsigns.undo_stage_hunk)
					map("n", "<leader>hS", gitsigns.stage_buffer)
					map("n", "<leader>hR", gitsigns.reset_buffer)
					map("n", "<leader>hp", gitsigns.preview_hunk)

					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)

					map("n", "<leader>gB", function()
						gitsigns.blame_line({
							full = true,
						})
					end)
					-- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
					map("n", "<leader>gh", gitsigns.diffthis)
					map("n", "<leader>GH", function()
						gitsigns.diffthis("~")
					end)
					map("n", "<leader>td", gitsigns.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
	-- visible marks
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({
				-- whether to map keybinds or not. default true
				default_mappings = true,
				-- which builtin marks to show. default {}
				builtin_marks = {},
				-- whether movements cycle back to the beginning/end of buffer. default true
				cyclic = true,
				-- whether the shada file is updated after modifying uppercase marks. default false
				force_write_shada = false,
				-- how often (in ms) to redraw signs/recompute mark positions.
				-- higher values will have better performance but may cause visual lag,
				-- while lower values may cause performance penalties. default 150.
				refresh_interval = 250,
				-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
				-- marks, and bookmarks.
				-- can be either a table with all/none of the keys, or a single number, in which case
				-- the priority applies to all marks.
				-- default 10.
				sign_priority = {
					lower = 10,
					upper = 15,
					builtin = 8,
					bookmark = 20,
				},
				-- disables mark tracking for specific filetypes. default {}
				excluded_filetypes = {},
				-- disables mark tracking for specific buftypes. default {}
				excluded_buftypes = {},
				-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
				-- sign/virttext. Bookmarks can be used to group together positions and quickly move
				-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
				-- default virt_text is "".
				bookmark_0 = {
					virt_text = "hello world",
					-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
					-- defaults to false.
					annotate = false,
				},
				mappings = {},
			})
		end,
	},
}
