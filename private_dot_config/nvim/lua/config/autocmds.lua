-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Restore underline cursor on exit (Alacritty doesn't reset it after nvim)
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.fn.chansend(vim.v.stderr, "\027[4 q")
  end,
})
