--- @module "lazy"
--- @type LazySpec
return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,

    keys = {
      { "<leader>cm", false },
      { "<leader>pm", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
}
