---@type LazySpec
return {
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = { "smoka7/hydra.nvim" },
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    opts = {},
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<C-g>"] = { "<cmd>MCstart<cr>", desc = "Create a selection for word under the cursor" },
        },
        v = {
          ["<C-g>"] = { "<cmd>MCstart<cr>", desc = "Create a selection for word under the cursor" },
        },
      },
    },
  },
}
