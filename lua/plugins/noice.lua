return {
  {
    "rcarriga/nvim-notify",
    --- @type notify.Config
    opts = {

      render = "compact",
      stages = "fade",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(
          opts.ensure_installed,
          { "bash", "markdown", "markdown_inline", "regex", "vim", "lua" }
        )
      end
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    --- @type NoiceConfig
    opts = {
      messages = {
        enabled = true,
        view = "mini", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
    },
  },
}
