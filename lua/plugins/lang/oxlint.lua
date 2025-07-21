return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      --- @module "lspconfig"
      ---@type lspconfig.options
      servers = {
        oxlint = {},
      },
    },
    --- --- @return lspconfig.Config
    --- opts = function()
    ---   vim.lsp.enable("oxlint")
    --- end,
  },
}
