-- tree disables base
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Configure how new splits should be opened
-- vim.opt.splitright = true
vim.opt.splitbelow = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- respect current path for nvim tree
-- vim.g.nvim_tree_respect_buf_cwd = 1
-- setup debug for python
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require("alex")
vim.cmd('source /home/user/.vimrc')
