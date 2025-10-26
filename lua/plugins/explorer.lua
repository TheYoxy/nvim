--- @type LazySpec
return {
  "folke/snacks.nvim",
  optional = true,
  --- @module "snacks"
  --- @type snacks.Config
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
          include = {
            "node_modules",
            "package-lock.json",
            "pnpm-lock.yaml",
            "yarn.lock",
          },
          win = {
            list = {
              keys = {
                ["x"] = "",
              },
            },
          },
        },
      },
    },
  },
}
