return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
			vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
			vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})

			-- change keys
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, {
				desc = "[F]ind [H]elp",
			})

			vim.keymap.set("n", "<leader>sk", builtin.keymaps, {
				desc = "[F]ind [K]eymaps",
			})

			vim.keymap.set("n", "<leader>sw", builtin.grep_string, {
				desc = "[F]ind current [W]ord",
			})

			vim.keymap.set("n", "<leader>sf", builtin.treesitter, {
				desc = "[S]earch functions",
			})
			vim.keymap.set("n", "<leader>scf", builtin.current_buffer_fuzzy_find, {
				desc = "[S]earch functions",
			})

			vim.keymap.set("n", "<leader>sc", builtin.colorscheme, {})
			vim.keymap.set("n", "<leader>sl", builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>si", builtin.lsp_incoming_calls, {})
			vim.keymap.set("n", "<leader>so", builtin.lsp_outgoing_calls, {})
			vim.keymap.set("n", "<leader>sdf", builtin.lsp_definitions, {})
			vim.keymap.set("n", "<leader>stf", builtin.lsp_type_definitions, {})
			vim.keymap.set("n", "<leader>sli", builtin.lsp_implementations, {})
			vim.keymap.set("n", "<leader>sws", builtin.lsp_workspace_symbols, {})
			vim.keymap.set("n", "<leader>sds", builtin.lsp_dynamic_workspace_symbols, {})

			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {
				desc = "[S]earch [D]iagnostics",
			})

			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, {
				desc = '[S]earch Recent Files ("." for repeat)',
			})

			-- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

			vim.keymap.set("n", "<leader>sb", builtin.buffers, {
				desc = "[ ] Find existing buffers",
			})

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = true,
				}))
			end, {
				desc = "[/] Fuzzily search in current buffer",
			})

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end, {
				desc = "[S]earch [N]eovim files",
			})
		end,
	},
}
