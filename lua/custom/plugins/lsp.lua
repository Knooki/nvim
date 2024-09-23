return {
	{ "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "L3MON4D3/LuaSnip" },
	{ "ckipp01/stylua-nvim" },
	{ "j-hui/fidget.nvim" },
	{ "folke/neodev.nvim" },
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					python = { "autopep8", "black", "isort", stop_after_first = true },
					json = { "jq" },
				},
			})
		end,
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
	},
	{

		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			-- Fix Undefined global 'vim'
			lsp_zero.configure("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			-- extending capabilities like code actions
			vim.g.lsp_zero_extend_capabilitites = true
			-- style of a windows for lsp(hower, diagnostics)
			vim.g.lsp_zero_ui_float_border = "double"
			-- signcolumn
			vim.g.lsp_zero_ui_signcolumn = true

			lsp_zero.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gh", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "gD", function()
					vim.lsp.buf.declaration()
				end, opts)
				vim.keymap.set("n", "gi", function()
					vim.lsp.buf.implementation()
				end, opts)
				vim.keymap.set("n", "go", function()
					vim.lsp.buf.type_definition()
				end, opts)
				vim.keymap.set("n", "gr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "gs", function()
					vim.lsp.buf.signature_help()
				end, opts)

				vim.keymap.set("n", "<leader>r", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("n", "<leader>ca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)

				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_prev()
				end, opts)

				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)
				vim.keymap.set("n", "<leader>q", function()
					vim.diagnostic.setloclist()
				end, { desc = "Open diagnostic [Q]uickfix list" })
			end)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					-- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>dws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap.
					-- map('K', vim.lsp.buf.hover, 'Hover Documentation')

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					-- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = { "tsserver", "lua_ls" },
				handlers = {
					-- temporary fix
					function(server_name)
						if server_name == "tsserver" then
							server_name = "ts_ls"
						end

						local capabilities = require("cmp_nvim_lsp").default_capabilities()
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})

						lsp_zero.default_setup(server_name)
					end,

					-- function(server_name)
					-- 	require("lspconfig")[server_name].setup({})
					-- end,

					lsp_zero.default_setup,
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
				},
			})

			-- { -- Autoformat
			--   'stevearc/conform.nvim',
			--   lazy = false,
			--   keys = {
			--     {
			--       '<leader>f',
			--       function()
			--         require('conform').format { async = true, lsp_fallback = true }
			--       end,
			--       mode = '',
			--       desc = '[F]ormat buffer',
			--     },
			--   },
			--   opts = {
			--     notify_on_error = false,
			--     format_on_save = function(bufnr)
			--       -- Disable "format_on_save lsp_fallback" for languages that don't
			--       -- have a well standardized coding style. You can add additional
			--       -- languages here or re-enable it for the disabled ones.
			--       local disable_filetypes = { c = true, cpp = true }
			--       return {
			--         timeout_ms = 500,
			--         lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			--       }
			--     end,
			--     formatters_by_ft = {
			--       lua = { 'stylua' },
			--       -- Conform can also run multiple formatters sequentially
			--       -- python = { "isort", "black" },
			--       --
			--       -- You can use a sub-list to tell conform to run *until* a formatter
			--       -- is found.
			--       -- javascript = { { "prettierd", "prettier" } },
			--     },
			--   },
			-- },

			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "sqls" },
					{ name = "buffer" },
				},
			})

			cmp.setup.filetype({ "python" }, {
				sources = {
					{ name = "python-lsp-server" },
				},
			})

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
				},
				formatting = lsp_zero.cmp_format(),
				preselect = cmp.PreselectMode.Item,
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
			})
		end,
	},

	--     { 'mhartington/formatter.nvim', config= function()
	--         -- Utilities for creating configurations
	-- local util = require "formatter.util"
	--  -- Autoformatting Setup
	--     end
	-- }

	-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
	-- require("formatter").setup {
	--   -- Enable or disable logging
	--   logging = true,
	--   -- Set the log level
	--   log_level = vim.log.levels.WARN,
	--   -- All formatter configurations are opt-in
	--   filetype = {
	--     -- Formatter configurations for filetype "lua" go here
	--     -- and will be executed in order
	--
	--     lua = {
	--       -- sytlua
	--       function()
	--
	-- local augroup = vim.api.nvim_create_augroup
	-- local autocmd = vim.api.nvim_create_autocmd
	-- augroup("__formatter__", { clear = true })
	-- autocmd("BufWritePost", {
	-- 	group = "__formatter__",
	-- 	command = ":FormatWrite",
	-- })
	--         return {
	--           exe = "stylua",
	--           args = {
	--             "--config-path "
	--               .. os.getenv "XDG_CONFIG_HOME"
	--               .. "/stylua/stylua.toml",
	--             "-",
	--
	--           },
	--           stdin = true,
	--         }
	--       end,
	--     },
	--
	--
	--     -- Use the special "*" filetype for defining formatter configurations on
	--     -- any filetype
	--     ["*"] = {
	--       -- "formatter.filetypes.any" defines default configurations for any
	--       -- filetype
	--       require("formatter.filetypes.any").remove_trailing_whitespace
	--     }
	--   }
	-- }

	-- end
	-- },
}
