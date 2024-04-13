require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>ff", ":Telescope <cr>")

-- TERMINAL
map({"n", "t"}, "<leader>tt", function()
  require("nvchad.term").toggle({pos="sp", id="floatTerm"})
end, { desc = "Terminal Toggle Floating term"})

map("n", "cc", "o<ESC>:ChatGPTCompleteCode<cr>")
map({"n", "v"}, "cj", ":ChatGPTEditWithInstructions<cr>")

map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
