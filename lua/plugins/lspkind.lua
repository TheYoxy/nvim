---@type LazySpec
return {
  "onsails/lspkind.nvim",
  opts = function(_, opts)
    -- use codicons preset
    opts.preset = "default"
    -- set some missing symbol types
    opts.symbol_map = {
      Array = "",
      Boolean = "",
      Key = "",
      Namespace = "",
      Null = "",
      Number = "",
      Object = "",
      Package = "",
      String = "",
    }
    return opts
  end,
}
