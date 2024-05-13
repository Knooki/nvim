-- Default options:
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = true,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = false,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function() -- add/modify highlights
        return {}
    end,
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = "none"
    -- {               -- map the value of 'background' option to a theme
    --     dark = "dragon",           -- try "dragon" !
    --     light = "lotus"
    -- },
})

--  wave the default heart-warming theme,
--  dragon for those late-night sessions
--  lotus for when you're out in the open.


function ColorMyPencils(color)
	color = color or "kanagawa-rave"
	vim.cmd.colorscheme(color)
end

-- ColorMyPencils()

-- vim.cmd.colorscheme "gruvbox"
