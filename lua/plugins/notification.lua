--- @type LazySpec
return {
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    optional = true,
    --- @module "noice"
    --- @type NoiceConfig
    opts = {
      notify = {
        enabled = true,
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
  },

  {
    "folke/snacks.nvim",
    optional = true,
    --- @module "snacks"
    --- @param opts snacks.config
    --- @return snacks.config
    opts = function(_, opts)
      opts.notifier.style = "fancy"
      return opts
    end,
  },
}
