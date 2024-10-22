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
          ["<C-g>"] = { "<cmd>MultipleCursorsAddJumpNextMatch<cr>", desc = "Add next cursor matches" },
          ["<C-G>"] = { "<cmd>MultipleCursorsAddMatches<cr>", desc = "Add all cursors matches" },
        },
        x = {
          ["<C-g>"] = { "<cmd>MultipleCursorsAddJumpNextMatch<cr>", desc = "Add next cursor matches" },
          ["<C-G>"] = { "<cmd>MultipleCursorsAddMatches<cr>", desc = "Add all cursors matches" },
        },
      },
    },
  },
}
