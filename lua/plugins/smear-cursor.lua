--- Neovim plugin to animate the cursor with a smear effect in all terminals
-- @type LazyPluginSpec
return {
  "sphamba/smear-cursor.nvim",
  enabled = false,
  event = "VeryLazy",
  cond = vim.g.neovide == nil and vim.g.vscode == nil,
  opts = {
    hide_target_hack = true,
    cursor_color = "none",
  },
  specs = {
    -- disable mini.animate cursor
    {
      "echasnovski/mini.animate",
      optional = true,
      opts = {
        cursor = { enable = false },
      },
    },
  },
}
