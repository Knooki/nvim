-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use "rebelot/kanagawa.nvim"
	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- harpoon
    use { 'nvim-lua/plenary.nvim' }
    use { 'ThePrimeagen/harpoon' }

	use('mbbill/undotree')
    -- git handliing
	use('tpope/vim-fugitive')
    use {
        "rbong/vim-flog",
      lazy = true,
      cmd = { "Flog", "Flogsplit", "Floggit" },
      dependencies = {
        "tpope/vim-fugitive",
      },
  }

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			--- Uncomment these if you want to manage LSP servers from neovim
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- LSP Support
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim'},

            -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
            -- used for completion, annotations and signatures of Neovim apis
            { 'folke/neodev.nvim'},
		}
	}
    use('davidhalter/jedi-vim')
    use { 'junegunn/fzf.vim' }
    use { 'junegunn/fzf', run = ":call fsf#install()" }
    use { 'mhartington/formatter.nvim' }
    use { 'jose-elias-alvarez/null-ls.nvim' }
    -- codeium
    use 'Exafunction/codeium.vim'
    -- zen mode
    use("folke/zen-mode.nvim")

    -- Highlight todo, notes, etc in comments
    use ({ 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } })
    -- trouble, like propose quick fix
    use({
      "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
          }
      end
      })
    -- markdown realtime priview
    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
    -- file tree
    use { "nvim-tree/nvim-tree.lua" }
    use { "nvim-tree/nvim-web-devicons" }
    -- vim be good
    use { "ThePrimeagen/vim-be-good" }


   -- nvim surround
    use({
        "kylechui/nvim-surround",
        tag = "main", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    -- debugger nvim-dap
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    -- DB
    use "tpope/vim-dadbod"
    use { "kristijanhusak/vim-dadbod-completion" }
    use { "kristijanhusak/vim-dadbod-ui" }
    -- themes
    use { "catppuccin/nvim", as = "catppuccin" }
    use { "ellisonleao/gruvbox.nvim" }
    -- comments
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    -- try hop
    use {
        'smoka7/hop.nvim',
        tag = 'v2', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }

end)
