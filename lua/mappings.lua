require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("t", "<C-`>", "<C-\\><C-n>", { desc = "Terminal mode to Normal Mode" })
