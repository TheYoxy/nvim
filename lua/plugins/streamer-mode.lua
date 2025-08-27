--- @module "lazy"
--- @type LazySpec
return {
  "Kolkhis/streamer-mode.nvim",
  event = "LazyFile",
  config = function(_, opts)
    require("streamer-mode").setup(opts)
  end,
  opts = {
    default_state = "on",
    paths = { ".env", ".env.local", ".env.development", ".env.production", ".env.test", "/tmp" },
  },
}
