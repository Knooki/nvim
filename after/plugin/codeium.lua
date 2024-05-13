-- disable default tab
vim.g.codeium_no_map_tab = 1
-- set new shortcut for codeium
vim.keymap.set('i', '<M-y>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
vim.keymap.set('i', '<M-Backspace>', function () return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
