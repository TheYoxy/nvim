---@type LazySpec
return {
  {
    "wakatime/vim-wakatime",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, 2, {
        require("wakatime.fn").wakatime,
        cond = function()
          return vim.g["loaded_wakatime"] == 1
        end,
        color = function()
          return { fg = Snacks.util.color("Normal") }
        end,
      })
    end,
  },
}
