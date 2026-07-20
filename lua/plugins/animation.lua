--- @type LazySpec
return {
  "folke/snacks.nvim",
  optional = true,
  --- @module "snacks"
  --- @type snacks.Config
  opts = {
    animate = {
      duration = 10,
      easing = "inOutQuad",
    },
  },
}
