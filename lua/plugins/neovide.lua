if not vim.g.neovide then return {} end -- NOTE: don't do anything in not vscode instances
vim.g.neovide_transparency = 0.3
vim.g.neovide_window_blurred = true
vim.g.transparency = 0.8
vim.g.neovide_font_settings = {
  ["GeistMono Nerd Font"] = {
    features = {
      "+ss07",
      "cv49=16",
      "cv94=1",
      "VXLA=2",
      "VXLC=2",
      "cv34=12",
      "cv31=13",
    },
  },
}
vim.o.guifont = "GeistMono Nerd Font,Symbols_Nerd_Font"

---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        winblend = 80,
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    --- @type NoiceConfig
    opts = {
      views = {
        cmdline_popup = {
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            winblend = 20, -- Adjust transparency level (0-100)
          },
        },
        popupmenu = {
          relative = "editor",
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            winblend = 20, -- Adjust transparency level (0-100)
          },
        },
      },
    },
  },
}
