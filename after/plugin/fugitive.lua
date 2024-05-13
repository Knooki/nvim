vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

local Alex_Fugutive = vim.api.nvim_create_augroup("Alex_Fugutive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = Alex_Fugutive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}
        vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git('push')
        end, opts)

        vim.keymap.set("n", "<leader>PF", function()
            vim.cmd.Git('push -f')
        end, opts)

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set("n", "<leader>po", ":Git push -u origin ", opts);

        -- reset to the previous commit
        vim.keymap.set("n", "<leader>rs", "<cmd>Git reset HEAD~1<CR>", opts);

        -- setup branch
        vim.keymap.set("n", "<leader>ps", ":Git push --set-upstream origin ", opts);
    end,
})
