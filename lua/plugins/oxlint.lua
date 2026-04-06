--- @module "lspconfig"
--- @module "lspconfig.configs"
--- @module "lspconfig.configs.tailwindcss"
--- @type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "oxlint" } },
  },
  {
    "neovim/nvim-lspconfig",
    ---@diagnostic disable missing-fields
    ---@type PluginLspOpts
    opts = {
      servers = {
        oxlint = {
          settings = {
            run = "onSave",
            -- configPath = nil,
            -- tsConfigPath = nil,
            -- unusedDisableDirectives = 'allow',
            typeAware = false,
            -- disableNestedConfig = false,
            -- fixKind = 'safe_fix',
          },
        },
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
        css = { "oxfmt" },
        markdown = { "oxfmt" },
        toml = { "oxfmt" },
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
