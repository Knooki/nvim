-- Hop*BC: run Hop* before the cursor.

-- Hop*AC: run Hop* after the cursor.

-- Hop*CurrentLine: run Hop* on the current line only.

-- Hop*MW: run Hop* across all visible buffers.


-- HopChar1
vim.keymap.set("n", "<leader>h1", "<cmd>HopChar1MW<CR>");


-- HopChar2
vim.keymap.set("n", "<leader>h2", "<cmd>HopChar2MW<CR>");

-- HopLineStart
vim.keymap.set("n", "<leader>hl", "<cmd>HopLineStartMW<CR>");

-- HopPattern
vim.keymap.set("n", "<leader>h/", "<cmd>HopPatternMW<CR>");
-- HopWord
vim.keymap.set("n", "<leader>hw", "<cmd>HopWordMW<CR>");


-- -- HopChar1
-- vim.keymap.set("n", "<leader>h!", "<cmd>HopChar1MW<CR>");
--
-- -- HopChar2
-- vim.keymap.set("n", "<leader>h@", "<cmd>HopChar2MW<CR>");
--
-- -- HopLineStart
-- vim.keymap.set("n", "<leader>hL", "<cmd>HopLineStartMW<CR>");
--
-- -- HopPattern
-- vim.keymap.set("n", "<leader>h?", "<cmd>HopPatternMW<CR>");
-- -- HopWord
-- vim.keymap.set("n", "<leader>hW", "<cmd>HopWordMW<CR>");
