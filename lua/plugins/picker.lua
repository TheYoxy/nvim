--- @type LazySpec
return {
  "folke/snacks.nvim",
  optional = true,
  --- @module "snacks"
  --- @type snacks.Config
  opts = {
    picker = {
      reverse = false,
      matcher = {
        cwd_bonus = true,
      },
      hidden = true,
      files = {
        hidden = true,
        ignored = true,
      },
      sources = {
        files = {
          hidden = true,
        },
        explorer = {
          hidden = true,
          include = {
            "package-lock.json",
            "pnpm-lock.yaml",
            "yarn.lock",
          },
        },
      },
    },
  },
}
