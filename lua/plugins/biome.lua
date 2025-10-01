vim.g.lazyvim_prettier_needs_config = true

-- https://biomejs.dev/internals/language-support/
local supported = {
  "astro",
  "css",
  "graphql",
  -- "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  -- "markdown",
  "svelte",
  "typescript",
  "typescriptreact",
  "vue",
  -- "yaml",
}

---@alias ConformCtx {buf: number, filename: string, dirname: string}
local M = {}

--- Checks if a Prettier config file exists for the given context
---@param ctx conform.Context
function M.has_config(ctx)
  return ctx.dirname
    and vim.fn.globpath(
        ctx.dirname,
        "{.biomerc,.biomerc.json,.biomerc.jsonc,.biomerc.js,.biomerc.cjs,.biomerc.mjs,.biome.json,.biome.jsonc}",
        true,
        true
      )
      ~= ""
end

M.has_config = LazyVim.memoize(M.has_config)

--- @type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "biome" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "biome")
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.biome = {
        require_cwd = true,
        condition = function(_, ctx)
          return M.has_config(ctx)
        end,
      }
    end,
  },

  -- none-ls support
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.biome)
    end,
  },
}
