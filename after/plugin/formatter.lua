-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    typescript = {
        function()
            return {
                exe = "prettierd",
                args = {vim.api.nvim_buf_get_name(0)},
                stdin = true
            }
        end
    },

    javascript = {
        function()
            return {
                exe = "prettierd",
                args = {vim.api.nvim_buf_get_name(0)},
                stdin = true
            }
        end
    },

    python = {
        function()
            return {
                exe = "autopep8 --in-place --aggressive",
                args = {vim.api.nvim_buf_get_name(0)},
                stding = true
            }
        end
    },

    json = {
        function()
            return {
                exe = "prettierd",
                args = {vim.api.nvim_buf_get_name(0)},
                stding = true
            }
        end
    },


    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
