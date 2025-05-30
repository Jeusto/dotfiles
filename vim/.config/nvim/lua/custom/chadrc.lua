---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "onedark" },

  hl_override = highlights.override,
  hl_add = highlights.add,
  nvdash = {
    load_on_startup = true,
    header = {
      "                              ",
    },
    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "  Projects", "Spc f p", "Telescope projects" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },

  cmp = {
    style = "default",
  },

  transparency = true,

  telescope = {
    style = "bordered",
  },

  statusline = {
    separator_style = "default",
  },

  lsp = {
    signature = {
      disabled = true,
      silent = true, -- silences 'no signature help available' message from appearing
    },
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

M.opts = {
  number = true,
  relativenumber = true,
  nuw = 2,
  smartcase = true,
  wrap = false,
  -- nowrap = true,
  format_on_save = true,
}

return M
