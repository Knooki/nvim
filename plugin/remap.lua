vim.g.mapleader = " "

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- tree
-- vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeOpen<CR>")
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>pr", ":NvimTreeRefresh<CR>")

-- move files
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set("n", "J", "mzJ`z")
-- cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- middle of the screen when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>pa", [["+p]]) -- PAste

-- delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<nop>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
function FormatFunction()
    vim.lsp.buf.format({
        formatting_options = {
            tabSize = 2,
            insertSpaces = true
        },
        async = true,
        range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
        }
    })
end

vim.api.nvim_set_keymap("v", "<leader>f", "<Esc><cmd>lua FormatFunction()<CR>", { noremap = true })

-- make curr file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod a+x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>X", "<cmd>!chmod a-x %<CR>", { silent = true })


-- git
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame -w -C -C -C<CR>")
vim.keymap.set("n", "<leader>gl", "<cmd>Flog<CR>")

-- neet
vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>")

-- open terminal in right split
vim.keymap.set("n", "<C-t>", "<cmd>vertical rightbelow terminal<CR>a")

vim.keymap.set("n", "<leader>tt", "anpm run test<CR><C-\\><C-n>")

-- open terminal in new tab
vim.keymap.set("n", "<C-S-t>", "<cmd>tab terminal<CR>a")

-- exit terminal mode
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])

-- search
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- window remaps
vim.keymap.set("n", "<leader>ww", "<C-w><C-w>")
vim.keymap.set("n", "<leader>wv", "<C-w>v")
vim.keymap.set("n", "<leader>ws", "<C-w>s")
vim.keymap.set("n", "<leader>wl", "<C-w>L")
vim.keymap.set("n", "<leader>wh", "<C-w>H")
vim.keymap.set("n", "<leader>wj", "<C-w>J")
vim.keymap.set("n", "<leader>wk", "<C-w>K")
vim.keymap.set("n", "<leader>wo", "<C-w><C-o>")
vim.keymap.set("n", "<leader>w.", "<cmd>vertical resize +10<CR>")
vim.keymap.set("n", "<leader>w,", "<cmd>vertical resize -10<CR>")
vim.keymap.set("n", "<leader>w=", "<cmd>resize +5<CR>")
vim.keymap.set("n", "<leader>w-", "<cmd>resize -5<CR>")


vim.keymap.set("n", "<A-l>", "<C-w>l")
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("t", "<A-l>", "<C-\\><C-N><C-w>l")
vim.keymap.set("t", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("i", "<A-l>", "<C-\\><C-N><C-w>l")
vim.keymap.set("i", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("i", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("i", "<A-k>", "<C-\\><C-N><C-w>k")

-- remaps for backspace and delete
-- c-h is backspace c-w is delete word backward
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-Delete>', '<Esc>ldei', { noremap = true })
-- m-backspace is alt-backspace
vim.api.nvim_set_keymap('i', '<M-Backspace>', '<Esc>ld0i', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-S-Delete>', '<Esc>ld$a', { noremap = true })
