if vim.fn.has("nvim-0.9.0") == 0 then
  vim.api.nvim_echo({
    { "LazyVim requires Neovim >= 0.9.0\n", "ErrorMsg" },
    { "Press any key to exit", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
  return {}
end

require("my-lazy.config.init").init()

--- @type LazySpec
return {
  { "folke/lazy.nvim", version = "*" },
  {
    name = "my-lazy/custom_nvim",
    url = "https://github.com/theyoxy/nvim-config",
    dir = vim.fn.stdpath("config") .. "/lua/my-lazy",
    priority = 10000,
    lazy = false,
    opts = {},
    cond = true,
    config = function(_, opts)
      require("my-lazy.init").setup(opts)
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
    config = function(_, opts)
      local notify = vim.notify
      require("snacks").setup(opts)
      -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
      -- this is needed to have early notifications show up in noice history
      if LazyVim.has("noice.nvim") then
        vim.notify = notify
      end
    end,
  },
}
