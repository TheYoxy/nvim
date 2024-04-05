---@type LazySpec
return {
  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    -- load only on require("tailwindcss-colors")
    -- module = "tailwindcss-colors",
    dependencies = {},
    -- run the setup function after plugin is loaded
    config = function()
      -- pass config options here (or nothing to use defaults)
      require("tailwindcss-colors").setup {}
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      handlers = {
        tailwindcss = function(_, opts) require("tailwindcss-colors").setup(opts) end,
      },
    },
  },
}
