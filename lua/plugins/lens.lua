if true then
  return {}
end

--- @module "lazy"
--- @type LazySpec
return {
  {
    "oribarilan/lensline.nvim",
    -- tag = "2.1.0", -- or: branch = 'release/2.x' for latest non-breaking updates
    branch = "release/2.x",
    event = "LspAttach",
    --- @module "lensline"
    opts = {},
    config = function()
      require("lensline").setup()
    end,
  },
}
