return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "oxlint" } },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      --- @module "lspconfig"
      ---@type table<string, lazyvim.lsp.Config|boolean>
      servers = {
        oxlint = {},
      },
    },
    --- --- @return lspconfig.Config
    --- opts = function()
    ---   vim.lsp.enable("oxlint")
    --- end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        json = { "oxfmt" },
        jsonc = { "oxfmt" },
        javascript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
      },
    },
  },
}
