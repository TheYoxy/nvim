---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.nix" },
  dependencies = {
    {
      "jay-babu/mason-null-ls.nvim",
      optional = true,
      opts = function(_, opts)
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "nil_ls" })
      end,
    },
    {
      "AstroNvim/astrolsp",
      optional = true,
      --- @type AstroLSPOpts
      opts = {
        ---@diagnostic disable: missing-fields
        config = {
          nil_ls = {
            settings = {
              ["nil"] = {
                nix = {
                  maxMemoryMB = 16384,
                  flake = {
                    autoEvalInputs = true,
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
