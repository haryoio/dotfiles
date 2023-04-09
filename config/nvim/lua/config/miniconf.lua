require("helper")
----------------
-- status line
----------------
local MiniStatusline = import("mini.statusline")
if MiniStatusline == nil then return end

local function diagnostics_table(args)
  local info = vim.b.coc_diagnostic_info
  if MiniStatusline.is_truncated(args.trunc_width) or info == nil then
    return {}
  end
  local table = {}
  table.e = (info['error'] or 0) > 0 and 'E'..info['error'] or ''
  table.w = (info['warning'] or 0) > 0 and 'W'..info['warning'] or ''
  table.h = (info['hint'] or 0) > 0 and 'H'..info['hint'] or ''
  table.i = (info['information'] or 0) > 0 and 'I'..info['information'] or ''
  table.s = vim.g.coc_status
  return table
end

local function status_config()
  local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
  local git           = MiniStatusline.section_git({ trunc_width = 75 })
  local diagnostics   = diagnostics_table({ trunc_width = 75 })
  local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
  local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
  local location      = MiniStatusline.section_location({ trunc_width = 75 })

  return MiniStatusline.combine_groups({
  { hl = mode_hl,                  strings = { mode } },
  { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics['s'] } },
  { hl = 'MiniStatuslineError',  strings = { diagnostics['e'] } },
  { hl = 'MiniStatuslineWarning',  strings = { diagnostics['w'] } },
  { hl = 'MiniStatuslineInfo',  strings = { diagnostics['i'] } },
  { hl = 'MiniStatuslineHint',  strings = { diagnostics['h'] } },
  '%<', -- Mark general truncate point
  { hl = 'MiniStatuslineFilename', strings = { filename } },
  '%=', -- End left alignment
  { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
  { hl = mode_hl,                  strings = { location } },
  })
end

require('mini.statusline').setup({
  content = {
    active = status_config
  },
})

----------------
-- autopairs
----------------

local mp = import("mini.pairs")
if mp == nil then return end
mp.setup({})

local mtl = import("mini.tabline")
if mtl == nil then return end
mtl.setup({})

local mt = import("mini.test")
if mt == nil then return end
mt.setup({})

local mtr = import("tmini.trailspace")
if mtr == nil then return end
mtr.setup({})


local mind = import("mini.indentscope")
if mind == nil then return end
-- mind.setup({})
--
local micom = import ("mini.comment")
if micom == nil then return end
micom.setup({
})
