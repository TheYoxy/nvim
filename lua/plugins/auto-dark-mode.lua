---@module "lazy"
---@type LazySpec
return {
  "f-person/auto-dark-mode.nvim",
  event = "VeryLazy",
  ---@module "auto-dark-mode"
  ---@type AutoDarkModeOptions
  opts = {
    set_dark_mode = function()
      vim.api.nvim_set_option_value("background", "dark", {
        scope = "global",
      })
      -- vim.cmd("colorscheme material-darker")
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {
        scope = "global",
      })
      -- vim.cmd("colorscheme tokyonight-day")
    end,
  },
}
