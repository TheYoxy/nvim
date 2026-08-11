--- @module "lazy"
--- @type LazySpec
return {
  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },
}
