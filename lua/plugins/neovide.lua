if not vim.g.neovide then
  return {}
end

vim.g.neovide_opacity = 0.6
vim.g.transparency = 0.8

vim.g.neovide_window_blurred = true
vim.g.neovide_font_settings = {
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

vim.o.guifont = "GeistMono Nerd Font,Symbols_Nerd_Font"

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

--- @module "lazy"
--- @type LazyVim
return {}
