---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
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
  },
}
