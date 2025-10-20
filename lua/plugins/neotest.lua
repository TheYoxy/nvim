--- @type lazy
return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "marilari88/neotest-vitest",
    },
    ---@module 'neotest'
    ---@type neotest.Config
    opts = {
      adapters = {
        ["neotest-vitest"] = {
          filter_dir = function(name)
            return name ~= "node_modules"
          end,
          -- Here we can set options for neotest-vitest
        },
      },
    },
  },
}
