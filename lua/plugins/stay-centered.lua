if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances
---@type LazySpec
return {
  "arnamak/stay-centered.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true,
  },
}
