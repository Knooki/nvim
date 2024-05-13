-- gc - single line
-- gb - block line
-- gcc - comment cur line
-- gbb - block comment curr
-- gco - o with comment
-- gcO - O with comment
-- gcA - A with comment

-- disable comments on new line
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

require('Comment').setup({
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = { line = 'gcc', block = 'gbc' },
    opleader = { line = 'gc', block = 'gb' },
    extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
    mappings = { basic = true, extra = true },
    pre_hook = nil,
    post_hook = nil,
})
