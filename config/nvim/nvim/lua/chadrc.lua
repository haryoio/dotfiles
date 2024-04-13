-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "gruvbox",
  transparency = false,

  tabufline = {
    enabled = true,
    order = { "treeOffset", "buffers", "tabs", "btns"},
    modules = nil,
  },
  lsp = { signature = true },
  telescope = { style = "borderless" },
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
  },
  term = {
    hl = "Normal:term,WinSeparator:WinSeparator",
    sizes = { sp = 0.3, vsp = 0.2 },
    pos = "sp", -- sp/vsp/float
    clear_cmd = true, -- needed for runner func*
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },
}

M.plugins = require "plugins"

return M
