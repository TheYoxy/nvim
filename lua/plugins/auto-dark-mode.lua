---@type LazySpec
return {
  "f-person/auto-dark-mode.nvim",
  ---@type AutoDarkModeOptions
  opts = {
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark")
      vim.cmd "colorscheme astrodark"
    end,
    set_light_mode = function()
      vim.api.nvim_set_option("background", "light")
      vim.cmd "colorscheme astrolight"
    end,
  },
}
