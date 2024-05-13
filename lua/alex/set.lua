vim.cmd [[
    :set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END
]]

vim.cmd [[
:nnoremap <silent> <leader>f :Format<CR>
:nnoremap <silent> <leader>F :FormatWrite<CR>
]]

-- :augroup FormatAutogroup
-- :  autocmd!
-- :  autocmd BufWritePost * FormatWrite
-- :augroup END
-- ]]

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- turn on highlight on F4
-- vim.opt.hlsearch = false
-- vim.cmd [[
-- :nnoremap <silent> <F4> :set hlsearch! hlsearch?<CR>
-- ]]
--
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')



vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.g.mapleader = " "
