if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances
-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==

  {
    "goolord/alpha-nvim",
    --- @type PluginOpts
    --- @param opts alpah
    opts = function(_, opts)
      local dashboard = require "alpha.themes.dashboard"
      -- customize the dashboard header
      opts.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      local get_icon = require("astroui").get_icon
      opts.section.buttons.val = {
        dashboard.button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
        dashboard.button("LDR f f", get_icon("Search", 2, true) .. "Find File  "),
        dashboard.button("LDR f e", get_icon("Search", 2, true) .. "Recently Opened Files"),
        dashboard.button("LDR f o", get_icon("DefaultFile", 2, true) .. "Recents  "),
        dashboard.button("LDR f w", get_icon("WordFile", 2, true) .. "Find Word  "),
        dashboard.button("LDR S l", get_icon("Refresh", 2, true) .. "Last Session  "),
        dashboard.button("LDR S l", get_icon("Refresh", 2, true) .. "Load Last Session"),
        dashboard.button("LDR S F", get_icon("Refresh", 2, true) .. "Load dir session"),
      }

      dashboard.config.layout = {
        { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
        dashboard.section.header,
        { type = "padding", val = 5 },
        dashboard.section.buttons,
        { type = "padding", val = 3 },
        dashboard.section.footer,
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
}
