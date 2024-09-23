return {
	{
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = true, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = {},
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				color_overrides = {},
				custom_highlights = {},
				default_integrations = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {
					SignColumn = {
						-- bg = "#282828",
						bg = "#1d2021",
					},
					NvimTreeNormal = {
						bg = "#282828",
					},
					NvimTreeNormalFloat = {
						bg = "#282828",
					},
					NvimTreeNormalNC = {
						bg = "#282828",
					},
				},
				dim_inactive = false,
				transparent_mode = false,
			})

			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"bluz71/vim-moonfly-colors",
		config = function()
			-- vim.cmd("colorscheme moonfly")
		end,
	},
	{ "sho-87/kanagawa-paper.nvim" },
	{
		"rebelot/kanagawa.nvim",
		config = function()
			-- Default options:
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = {
					italic = true,
				},
				functionStyle = {},
				keywordStyle = {
					italic = true,
				},
				statementStyle = {
					bold = true,
				},
				typeStyle = {},
				transparent = false, -- do not set background color
				dimInactive = true, -- dim inactive window `:h hl-NormalNC`
				terminalColors = false, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = {
						wave = {},
						lotus = {},
						dragon = {},
						all = {},
					},
				},
				overrides = function() -- add/modify highlights
					return {}
				end,
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = "none",
				-- {               -- map the value of 'background' option to a theme
				--     dark = "dragon",           -- try "dragon" !
				--     light = "lotus"
				-- },
			})

			--  wave the default heart-warming theme,
			--  dragon for those late-night sessions
			--  lotus for when you're out in the open.

			-- vim.cmd.colorscheme("kanagawa")

			-- ColorMyPencils()

			-- vim.cmd.colorscheme "gruvbox"
		end,
	},
	{
		"rockyzhang24/arctic.nvim",
		branch = "v2",
		dependencies = { "rktjmp/lush.nvim" },
	},
	{
		"0xstepit/flow.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
