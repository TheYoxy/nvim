if not vim.g.neovide then
  return {}
end

vim.g.neovide_opacity = 0.6
vim.g.transparency = 0.8

vim.g.winblend = 100
vim.g.pumblend = 100
vim.g.neovide_window_blurred = true
vim.g.neovide_font_settings = {
  ["JetBrains Mono"] = {
    features = {
      "+calt",
      "+zero",
      "+ss01",
      "+ss02",
      "+cv01",
      "+cv02",
      "+cv03",
      "+cv04",
      "+cv05",
      "+cv06",
      "+cv07",
      "+cv08",
      "+cv09",
      "+cv10",
      "+cv11",
      "+cv12",
      "+cv14",
      "+cv15",
      "+cv16",
      "+cv17",
      "+cv18",
      "+cv19",
      "+cv20",
      "+cv99",
    },
  },
  ["Geist Mono"] = {
    features = {
      "+ss07",
      "cv46=16",
      "cv94=1",
      "VXLA=2",
      "VXLC=2",
      "cv34=12",
      "cv31=13",
    },
  },
  ["GeistMono Nerd Font"] = {
    features = {
      "+ss07",
      "cv46=16",
      "cv94=1",
      "VXLA=2",
      "VXLC=2",
      "cv34=12",
      "cv31=13",
    },
  },
}

local uname = io.popen("uname"):read("*l")
if uname == "Linux" then
  vim.o.guifont = "JetBrains Mono,GeistMono Nerd Font,Symbols_Nerd_Font"
else
  vim.o.guifont = "JetBrains Mono,Geist Mono,GeistMono Nerd Font,PowerlineSymbols"
end

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
    "nvim-treesitter/nvim-treesitte-context",
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
        vim.api.nvim_set_option("background", "dark")
        vim.g.neovide_floating_shadow = true
      end,
      set_light_mode = function()
        vim.g.neovide_floating_shadow = false
        vim.api.nvim_set_option("background", "light")
      end,
    },
  },
}
