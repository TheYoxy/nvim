---@type LazySpec
return {
  "f-person/auto-dark-mode.nvim",
  ---@type AutoDarkModeOptions
  opts = {
    set_dark_mode = function()
      vim.api.nvim_set_option_value("background", "dark", {
        scope = "global",
      })
      vim.cmd "colorscheme github_dark_dimmed"
      -- vim.cmd "colorscheme astrodark"
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {
        scope = "global",
      })
      vim.cmd "colorscheme github_light"
      -- vim.cmd "colorscheme astrolight"
    end,
  },
}
