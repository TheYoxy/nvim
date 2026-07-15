if true then
  return {}
end

vim.g.snacks_animate = false -- disable all animations
--- @type LazySpec
return {
  {
    --- @module "stay-centered"
    "arnamak/stay-centered.nvim",
    lazy = false,
    enabled = true,
    opts = {
      skip_filetypes = {},
    },
  },
}
