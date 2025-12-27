--- @type LazySpec
return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "saifulapm/neotree-file-nesting-config",
    },
    --- @module "neo-tree"
    --- @param opts neotree.Config
    opts = function(_, opts)
      opts.hide_root_node = true
      opts.retain_hidden_root_indent = true
      opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}
      opts.filesystem.filtered_items.hide_dotfiles = false
      opts.filesystem.filtered_items.hide_gitignored = true
      opts.filesystem.filtered_items.hide_hidden = false
      opts.filesystem.filtered_items.show_hidden_count = false
      opts.filesystem.filtered_items.never_show = {
        ".DS_Store",
      }
      opts.window.position = "right"

      opts.nesting_rules = require("neotree-file-nesting-config").nesting_rules
      opts.window.mappings.l = { "open", config = { expand_nested_files = true } }
    end,
  },
}
