return {
  {
    "bjarneo/aether.nvim",
    name = "aether",
    priority = 1000,
    opts = {
      disable_italics = false,
      colors = {
        -- Monotone shades (base00-base07)
        base00 = "#080C07", -- Default background
        base01 = "#384435", -- Lighter background (status bars)
        base02 = "#080C07", -- Selection background
        base03 = "#384435", -- Comments, invisibles
        base04 = "#ECEAEC", -- Dark foreground
        base05 = "#ffffff", -- Default foreground
        base06 = "#ffffff", -- Light foreground
        base07 = "#ECEAEC", -- Light background

        -- Accent colors (base08-base0F)
        base08 = "#fe2a2f", -- Variables, errors, red
        base09 = "#ff8588", -- Integers, constants, orange
        base0A = "#d1b775", -- Classes, types, yellow
        base0B = "#89ae8b", -- Strings, green
        base0C = "#91dee3", -- Support, regex, cyan
        base0D = "#AEB6CA", -- Functions, keywords, blue
        base0E = "#B9788A", -- Keywords, storage, magenta
        base0F = "#eadcb8", -- Deprecated, brown/yellow
      },
    },
    config = function(_, opts)
      require("aether").setup(opts)
      vim.cmd.colorscheme("aether")

      -- Enable hot reload
      require("aether.hotreload").setup()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
