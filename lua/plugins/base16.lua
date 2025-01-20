-- Last updated: 25/07/24
if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances
if true then return {} end -- NOTE: disable this plugin

---@type LazySpec
return {
  {
    "RRethy/base16-nvim",
    lazy = true,
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      -- colorscheme = "base16-default-dark",
    },
  },
}
