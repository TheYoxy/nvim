---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = vim.g.transparent,
      style = "moon",
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
