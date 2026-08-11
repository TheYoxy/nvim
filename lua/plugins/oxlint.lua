local supported = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "jsonc",
  "vue",
  "svelte",
  "astro",
  "css",
}

--- @module "lazy"
--- @module "lspconfig"
--- @module "lspconfig.configs"
--- @module "lspconfig.configs.tailwindcss"
--- @type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "oxlint", "oxfmt" } },
  },
  {
    "neovim/nvim-lspconfig",
    ---@diagnostic disable missing-fields
    ---@type PluginLspOpts
    opts = {
      servers = {
        ---@type lspconfig.settings.oxlint
        oxlint = {
          root_dir = function(bufnr, on_dir)
            -- prefer the top-level oxlint config if it exists (monorepo support)
            local git = vim.fs.root(bufnr, ".git")
            local markers = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" }
            local root = git and vim.fs.root(git, markers) or vim.fs.root(bufnr, markers)
            if root then
              on_dir(root)
            end
          end,

          settings = {
            run = "onSave",
            -- configPath = nil,
            -- tsConfigPath = nil,
            unusedDisableDirectives = "deny",
            typeAware = true,
            -- disableNestedConfig = false,
            -- fixKind = 'safe_fix',
            fixKind = "safe_fix_or_suggestion",
          },
        },

        --- disable the oxfmt lsp server since we use conform for formatting
        oxfmt = { enabled = false },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "oxfmt")
      end
    end,
  },
}
