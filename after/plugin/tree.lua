-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
-- require("nvim-tree").setup()

-- global
-- local api = require("nvim-tree.api")

-- vim.keymap.set("n", "h", api.tree.close)
-- vim.keymap.set("n", "H", api.tree.collapse_all)

local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.5   -- You can change this too

local tree_api = require("nvim-tree")
local tree_view = require("nvim-tree.view")

vim.api.nvim_create_augroup("NvimTreeResize", {
  clear = true,
})

vim.api.nvim_create_autocmd("VimEnter", {
  command = "NvimTreeToggle",
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = "NvimTreeResize",
  callback = function()
    if tree_view.is_visible() then
      tree_view.close()
      tree_api.open()
    end
  end
})

tree_api.setup({
  -- added for updating tree if file changes
  auto_reload_on_write = true,
  hijack_cursor = true,
  -- hijack_unnamed_buffer_when_opening=true,

  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
   },
  renderer = {
    add_trailing = false,
    group_empty = true,
    full_name = false,
    root_folder_label = ":~:s?$?/..?",
    indent_width = 2,
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    symlink_destination = true,
    highlight_git = false,
    highlight_diagnostics = "all",
    highlight_opened_files = "none",
    highlight_modified = "none",
    highlight_bookmarks = "none",
    highlight_clipboard = "name",
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      web_devicons = {
        file = {
          enable = true,
          color = true,
        },
        folder = {
          enable = true,
          color = true,
        },
      },
      git_placement = "before",
      modified_placement = "after",
      diagnostics_placement = "signcolumn",
      bookmarks_placement = "signcolumn",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
        diagnostics = true,
        bookmarks = false,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        modified = "*",
        folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
        },
      git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌",
      },
      },
    },
  },
  git = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
  },
  diagnostics = {
      enable=true,
      show_on_dirs=true,
      show_on_open_dirs=true,
      severity = {
          min = vim.diagnostic.severity.ERROR,
          max = vim.diagnostic.severity.ERROR,
      }
  },
  modified = {
      enable = true,
  },
  view = {
    cursorline=true,
    relativenumber=true,
    signcolumn = "yes",
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
        end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
})

-- local function change_root_to_global_cwd()
--   local api = require("nvim-tree.api")
--   local global_cwd = vim.fn.getcwd(-1, -1)
--   api.tree.change_root(global_cwd)
-- end
