return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji", -- add cmp source as dependency of cmp
    "hrsh7th/cmp-cmdline", -- add cmp-cmdline as dependency of cmp
  },
  keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
  config = function(_, opts)
    local cmp = require "cmp"
    -- run cmp setup
    cmp.setup(opts)

    -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    -- modify the sources part of the options table
    opts.sources = cmp.config.sources {
      { name = "nvim_lsp", priority = 1000 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
      { name = "emoji", priority = 110 },
      { name = "luasnip", priority = 100 },
    }
  end,
}
