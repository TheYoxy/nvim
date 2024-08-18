---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
      vtsls = {
        on_attach = function(client, bufnr) require("twoslash-queries").attach(client, bufnr) end,
      },
    },
  },
  dependencies = {
    "marilari88/twoslash-queries.nvim",
    event = "VeryLazy",
    opts = {
      multi_line = true,
    },
  },
}
