local M = {}

function import(module_name)
  local ok, module = pcall(require, module_name)
  if ok then
    return module
  else
    return nil
  end
end

M.keybind = function()
	map = vim.keymap.set

	function nmap(key, action, option)
		map("n", key, action, option)
	end

	function imap(key, action, option)
		map("i", key, action, option)
	end

	function tmap(key, action, option)
		map("t", key, action, option)
	end

	function vmap(key, action, option)
		map("v", key, action, option)
	end
end

return M
