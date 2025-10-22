---@diagnostic disable: missing-fields
--- @type LazySpec
return {
  "saghen/blink.cmp",
  optional = true,
  --- @module "blink.cmp"
  --- @param opts blink.cmp.Config
  opts = function(_, opts)
    opts.sources.default = { "lsp", "path", "buffer" }
    opts.signature = opts.signature or {}
    opts.signature.enabled = true
    opts.completion.menu.border = "shadow"
    opts.completion.menu.draw.columns = { { "label", "label_description", gap = 1 }, {
      "kind_icon",
      "kind",
    } }
  end,
}
