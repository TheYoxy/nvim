---@type LazySpec
return {
  {
    "marilari88/twoslash-queries.nvim",
    event = "VeryLazy",
    opts = {
      multi_line = true,
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        tsserver = {
          on_attach = function(client, bufnr) require("twoslash-queries").attach(client, bufnr) end,
        },
      },
    },
  },
}
