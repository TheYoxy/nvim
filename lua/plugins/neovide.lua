if not vim.g.neovide then
  return {}
end

vim.g.neovide_opacity = 0.8
vim.g.transparency = 0.8

vim.g.winblend = 100
vim.g.pumblend = 100
vim.g.neovide_window_blurred = true

-- local uname = io.popen("uname"):read("*l")
-- if uname == "Linux" then
--   vim.o.guifont = "PowerlineSymbols,Symbols_Nerd_Font,JetBrains Mono,GeistMono Nerd Font"
-- else
--   vim.o.guifont = "JetBrains Mono,PowerlineSymbols"
-- end

vim.api.nvim_set_keymap("n", "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_blur_amount_x = 30
vim.g.neovide_floating_blur_amount_y = 30
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

vim.g.neovide_position_animation_length = 0.1
vim.g.neovide_scroll_animation_length = 0.1
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_animate_command_line = false

--- @module "lazy"
--- @type LazySpec
return {
  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    optional = true,
    opts = {
      multiwindow = true,
      line_numbers = false,
      multiline_threshold = 2,
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    optional = true,
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        -- vim.g.neovide_floating_shadow = true
      end,
      set_light_mode = function()
        -- vim.g.neovide_floating_shadow = true
        vim.api.nvim_set_option_value("background", "light", {})
      end,
    },
  },
}
