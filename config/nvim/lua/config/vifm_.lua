
local vifm = require("vifm")  -- Assuming you saved the Vifm Lua code in a file named "vifm.lua"

-- Define a function to use the Vifm wrapper with floaterm
local function open_vifm_in_floaterm()
  local cmd, jobopts, config = vifm.floaterm_wrapper_vifm("vifm", {}, {})
  vim.fn["floaterm#new"](cmd, jobopts, config)
end

-- Create a command to use the function
vim.api.nvim_command("command! VifmFloaterm lua open_vifm_in_floaterm()")

return {}
