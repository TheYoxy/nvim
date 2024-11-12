if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances

---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.utility.noice-nvim" },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "MunifTanjim/nui.nvim",
      },
      {

        "rcarriga/nvim-notify",
        --- @type notify.Config
        --- @diagnostic disable: missing-fields
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
    },
    --- @type NoiceConfig
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
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
