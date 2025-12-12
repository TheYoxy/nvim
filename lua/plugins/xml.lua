--- @type LazySpec
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    --- @module "lspconfig"
    --- @type lspconfig.Config
    opts = {
      servers = {
        lemminx = {},
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "lemminx" } },
  },
}
