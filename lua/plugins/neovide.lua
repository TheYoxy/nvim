if not vim.g.neovide then
  return {}
end

vim.g.neovide_opacity = 0.6
vim.g.transparency = 0.8

vim.g.neovide_window_blurred = true
vim.g.neovide_font_settings = {
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
  vim.o.guifont = "GeistMono Nerd Font,Symbols_Nerd_Font"
else
  vim.o.guifont = "Geist Mono,GeistMono Nerd Font,PowerlineSymbols"
end

vim.api.nvim_set_keymap(
  "n",
  "<C-=>",
  ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
  { silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-->",
  ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
  { silent = true }
)
vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

vim.g.neovide_position_animation_length = 0.1
vim.g.neovide_scroll_animation_length = 0.1
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_animate_command_line = false

--- @module "lazy"
--- @type LazyVim
return {
  "snacks.nvim",
  opts = {
    scroll = { enabled = false },
  },
}
