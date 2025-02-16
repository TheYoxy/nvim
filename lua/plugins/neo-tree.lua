---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "saifulapm/neotree-file-nesting-config",
  },
  ---@type neotree
  opts = {
    sources = { "filesystem" },
    filesystem = {
      hijack_netrw_behavior = "open_default",
      filtered_items = {
        hide_gitignored = true,
        hide_dotfiles = false,
        hide_hidden = false,
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
      follow_current_file = {
        enabled = true,
      },
    },
    buffers = {
      enabled = false,
    },
    git_status = {
      enabled = false,
    },
  },
  config = function(_, opts)
    opts.nesting_rules = require("neotree-file-nesting-config").nesting_rules
    require("neo-tree").setup(opts)
  end,
}
