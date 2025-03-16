--- @module "lazy"
--- @type LazySpec
return {
  "Kolkhis/streamer-mode.nvim",
  opts = {
    default_state = "on",
    paths = { ".env", ".env.local", ".env.development", ".env.production", ".env.test" },
  },
}
