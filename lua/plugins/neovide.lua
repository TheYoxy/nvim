if not vim.g.neovide then return {} end -- NOTE: don't do anything in not vscode instances
vim.g.neovide_transparency = 0.0
vim.g.transparency = 0.8

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
