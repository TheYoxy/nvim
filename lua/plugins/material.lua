---@module "lazy"
---@type LazySpec
return {
  "marko-cerovac/material.nvim",
  --- @module "material"
  opts = {
    plugins = { -- Uncomment the plugins that you use to highlight them
      -- Available plugins:
      "coc",
      "colorful-winsep",
      "dap",
      "dashboard",
      "eyeliner",
      "fidget",
      "flash",
      "gitsigns",
      "harpoon",
      "hop",
      "illuminate",
      "indent-blankline",
      "lspsaga",
      "mini",
      "neogit",
      "neotest",
      "neo-tree",
      "neorg",
      "noice",
      "nvim-cmp",
      "nvim-navic",
      "nvim-tree",
      "nvim-web-devicons",
      "rainbow-delimiters",
      "sneak",
      "telescope",
      "trouble",
      "which-key",
      "nvim-notify",
    },
    theme = "material-stealth",
    styles = {
      comments = {
        italic = true,
      },
    },
    disable = {
      background = true,
      term_colors = true,
    },
    lualine_style = "stealth",
  },
}
