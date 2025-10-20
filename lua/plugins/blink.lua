--- @type LazySpec
return {
  "saghen/blink.cmp",
  optional = true,
  --- @module "blink.cmp"
  --- @param opts blink.cmp.Config
  opts = function(_, opts)
    opts.sources.default = { "lsp", "path", "buffer" }
  end,
}
