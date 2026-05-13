return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local function repo_name()
      local root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
      if root and root ~= "" then
        return " " .. vim.fn.fnamemodify(root, ":t")
      end
      return ""
    end

    table.insert(opts.sections.lualine_b, 1, repo_name)
  end,
}
