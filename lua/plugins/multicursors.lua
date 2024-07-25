---@type LazySpec
return {
  "brenton-leighton/multiple-cursors.nvim",
  cmd = {
    "MultipleCursorsAddDown",
    "MultipleCursorsAddUp",
    "MultipleCursorsMouseAddDelete",
    "MultipleCursorsAddMatches",
    "MultipleCursorsAddMatchesV",
    "MultipleCursorsAddJumpNextMatch",
    "MultipleCursorsJumpNextMatch",
    "MultipleCursorsLock",
  },
  opts = {},
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<C-g>"] = { "<cmd>MultipleCursorsAddMatches<cr>", desc = "Add cursor matches" },
        },
        x = {
          ["<C-g>"] = { "<cmd>MultipleCursorsAddMatches<cr>", desc = "Add cursor matches" },
        },
      },
    },
  },
}
