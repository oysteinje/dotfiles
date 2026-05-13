-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>.", function()
  Snacks.picker.files({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Find Files (buffer dir)" })

vim.keymap.set("n", "<leader>bk", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

vim.keymap.set("n", "<leader>bb", function()
  Snacks.picker.buffers()
end, { desc = "Switch Buffer" })
