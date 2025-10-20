--- @module "lazy"
--- @type LazySpec
return {
  {
    "f-person/auto-dark-mode.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        --- @module "tokyonight"
        --- @type tokyonight.Config
        opts = {
          style = "moon",
          transparent = true, -- Enable this to disable setting the background color
        },
      },
      --- @module "onedark"
      {
        "navarasu/onedark.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
          require("onedark").setup({
            style = "darker",
            transparent = true,
            term_colors = true,
            lualine = {
              transparent = true,
            },
            diagnostics = {
              darker = true, -- darker colors for diagnostic
              undercurl = true, -- use undercurl instead of underline for diagnostics
              background = true, -- use background color for virtual text
            },
          })
          -- Enable theme
          require("onedark").load()
        end,
      },
      --- @module "material"
      {
        "marko-cerovac/material.nvim",
        enabled = true,
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
            -- term_colors = true,
          },
          lualine_style = "stealth",
        },
      },
    },
    ---@module "auto-dark-mode"
    ---@type AutoDarkModeOptions
    opts = {
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {
          scope = "global",
        })
        vim.cmd("colorscheme material")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {
          scope = "global",
        })
        vim.cmd("colorscheme onedark")
      end,
    },
  },
}
